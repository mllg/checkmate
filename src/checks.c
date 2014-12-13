#include "checks.h"
#include <ctype.h>
#include <string.h>
#include "as_type.h"
#include "cmessages.h"
#include "is_integerish.h"
#include "any_missing.h"
#include "any_infinite.h"
#include "all_missing.h"
#include "all_nchar.h"
#include "bounds.h"
#include "helper.h"


/*********************************************************************************************************************/
/* Some helpers                                                                                                      */
/*********************************************************************************************************************/
typedef enum { T_UNDEF, T_UNNAMED, T_NAMED, T_UNIQUE, T_STRICT } name_t;

static inline double asTol(SEXP tol) {
    return asNumber(tol, "tol");
}

static inline Rboolean is_scalar_na(SEXP x) {
    if (length(x) == 1) {
        switch(TYPEOF(x)) {
            case LGLSXP: return (LOGICAL(x)[0] == NA_LOGICAL);
            case INTSXP: return (INTEGER(x)[0] == NA_INTEGER);
            case REALSXP: return ISNAN(REAL(x)[0]);
            case STRSXP: return (STRING_ELT(x, 0) == NA_STRING);
        }
    }
    return FALSE;
}

static inline Rboolean is_vector(SEXP x) {
    SEXP attr = ATTRIB(x);
    if (length(attr) > 0 && (TAG(attr) != R_NamesSymbol || CDR(attr) != R_NilValue))
        return FALSE;
    return TRUE;
}

/*********************************************************************************************************************/
/* Shared check functions returning an intermediate msg_t                                                            */
/*********************************************************************************************************************/
static Rboolean check_valid_names(SEXP x) {
    return !isNull(x) && !any_missing_string(x) && all_nchar(x, 1);
}

static Rboolean check_unique_names(SEXP x) {
    return any_duplicated(x, FALSE) == 0;
}

static Rboolean check_strict_names(SEXP x) {
    const R_len_t nx = length(x);
    const char *str;
    for (R_len_t i = 0; i < nx; i++) {
        str = CHAR(STRING_ELT(x, i));
        while (*str == '.')
            str++;
        if (!isalpha(*str))
            return FALSE;
        for (; *str != '\0'; str++) {
            if (!isalnum(*str) && *str != '.' && *str != '_')
                return FALSE;
        }
    }
    return TRUE;
}

static name_t get_name_type(SEXP type) {
    const char * const ctype = asString(type, "type");
    if (strcmp(ctype, "unnamed") == 0)
        return T_UNNAMED;
    if (strcmp(ctype, "named") == 0)
        return T_NAMED;
    if (strcmp(ctype, "unique") == 0)
        return T_UNIQUE;
    if (strcmp(ctype, "strict") == 0)
        return T_STRICT;
    error("Unknown type definition '%s'", ctype);
}

static name_t check_type(SEXP nn, name_t type) {
    if (type == T_UNNAMED) {
        if (!isNull(nn))
            return T_UNNAMED;
    } else {
        if (!check_valid_names(nn))
            return T_NAMED;

        if (type >= T_UNIQUE) {
            if (!check_unique_names(nn))
                return T_UNIQUE;

            if (type >= T_STRICT && !check_strict_names(nn))
                return T_STRICT;
        }
    }
    return T_UNDEF;
}

static msg_t check_names(SEXP x, SEXP nn, SEXP type, const char * what) {
    name_t ntype = get_name_type(type);
    if (length(x) > 0) {
        switch(check_type(nn, ntype)) {
            case T_UNDEF: break;
            case T_UNNAMED: return Msgf("%s must be unnamed", what);
            case T_NAMED: return Msgf("%s must be named", what);
            case T_UNIQUE: return Msgf("%s must be uniquely named", what);
            case T_STRICT: return Msgf("%s must be named according to R's variable naming rules", what);
        }
    }
    return MSGT;
}

static msg_t check_vector_props(SEXP x, SEXP any_missing, SEXP all_missing, SEXP len, SEXP min_len, SEXP max_len, SEXP unique, SEXP names) {
    if (!isNull(len)) {
        R_len_t n = asCount(len, "len");
        if (length(x) != n)
            return Msgf("Must have length %i", n);
    }

    if (!isNull(min_len)) {
        R_len_t n = asCount(min_len, "min.len");
        if (length(x) < n)
            return Msgf("Must have length >= %i", n);
    }

    if (!isNull(max_len)) {
        R_len_t n = asCount(max_len, "max.len");
        if (length(x) > n)
            return Msgf("Must have length <= %i", n);
    }

    if (!asFlag(any_missing, "any.missing") && any_missing_atomic(x))
        return Msg("Contains missing values");

    if (!asFlag(all_missing, "all.missing") && all_missing_atomic(x))
        return Msg("Contains only missing values");

    if (asFlag(unique, "unique") && any_duplicated(x, FALSE) > 0)
        return Msg("Contains duplicated values");

    if (!isNull(names))
        return check_names(x, getAttrib(x, R_NamesSymbol), names, "Vector");
    return MSGT;
}

static msg_t check_matrix_props(SEXP x, SEXP any_missing, SEXP min_rows, SEXP min_cols, SEXP rows, SEXP cols) {
    if (!isNull(min_rows) || !isNull(rows)) {
        R_len_t xrows = get_nrows(x);
        if (!isNull(min_rows)) {
            R_len_t cmp = asCount(min_rows, "min.rows");
            if (xrows < cmp)
                return Msgf("Must have at least %i rows", cmp);
        }
        if (!isNull(rows)) {
            R_len_t cmp = asCount(rows, "rows");
            if (xrows != cmp)
                return Msgf("Must have exactly %i rows", cmp);
        }
    }
    if (!isNull(min_cols) || !isNull(cols)) {
        R_len_t xcols = get_ncols(x);
        if (!isNull(min_cols)) {
            R_len_t cmp = asCount(min_cols, "min.cols");
            if (xcols < cmp)
                return Msgf("Must have at least %i cols", cmp);
        }
        if (!isNull(cols)) {
            R_len_t cmp = asCount(cols, "cols");
            if (xcols != cmp)
                return Msgf("Must have exactly %i cols", cmp);
        }
    }

    if (!asFlag(any_missing, "any.missing") && any_missing_atomic(x))
        return Msg("Contains missing values");

    return MSGT;
}

static msg_t check_storage(SEXP x, SEXP mode) {
    if (!isNull(mode)) {
        const char * const storage = asString(mode, "mode");
        if (strcmp(storage, "logical") == 0) {
            if (!isLogical(x))
                return Msg("Must contain logicals");
        } else if (strcmp(storage, "integer") == 0) {
            if (!isInteger(x))
                return Msg("Must contain integers");
        } else if (strcmp(storage, "double") == 0) {
            if (!isReal(x))
                return Msg("Must contain doubles");
        } else if (strcmp(storage, "numeric") == 0) {
            if (!isStrictlyNumeric(x))
                return Msg("Must contain numerics");
        } else if (strcmp(storage, "complex") == 0) {
            if (!isComplex(x))
                return Msg("Must contain complexs");
        } else if (strcmp(storage, "character") == 0) {
            if (!isString(x))
                return Msg("Must contain characters");
        } else {
            error("Invalid argument 'mode'. Must be one of 'logical', 'integer', 'double', 'numeric', 'complex' or 'character'");
        }
    }
    return MSGT;
}

static msg_t check_array_props(SEXP x, SEXP any_missing, SEXP d) {
    if (!isNull(d)) {
        int di = asCount(d, "d");
        if (LENGTH(getAttrib(x, R_DimSymbol)) != di)
            return Msgf("Must be %i-d array", di);
    }
    if (!asFlag(any_missing, "any.missing") && any_missing_atomic(x))
        return Msg("Contains missing values");

    return MSGT;
}


/*********************************************************************************************************************/
/* Exported check functions                                                                                          */
/*********************************************************************************************************************/
SEXP c_check_character(SEXP x, SEXP min_chars, SEXP any_missing, SEXP all_missing, SEXP len, SEXP min_len, SEXP max_len, SEXP unique, SEXP names) {
    if (!isString(x) && !all_missing_atomic(x))
        return CheckResult("Must be a character");
    if (!isNull(min_chars)) {
        R_len_t n = asCount(min_chars, "min.chars");
        if (n > 0 && !all_nchar(x, n))
            return CheckResultf("All elements must have at least %i characters", n);
    }
    return mwrap(check_vector_props(x, any_missing, all_missing, len, min_len, max_len, unique, names));
}

SEXP c_check_complex(SEXP x, SEXP any_missing, SEXP all_missing, SEXP len, SEXP min_len, SEXP max_len, SEXP unique, SEXP names) {
    if (!isComplex(x) && !all_missing_atomic(x))
        return CheckResult("Must be complex");
    return mwrap(check_vector_props(x, any_missing, all_missing, len, min_len, max_len, unique, names));
}

SEXP c_check_dataframe(SEXP x, SEXP any_missing, SEXP min_rows, SEXP min_cols, SEXP rows, SEXP cols, SEXP row_names, SEXP col_names) {
    if (!isFrame(x))
        return CheckResult("Must be a data frame");

    msg_t msg = check_matrix_props(x, any_missing, min_rows, min_cols, rows, cols);
    if (!msg.ok)
        return mwrap(msg);


    if (!isNull(row_names)) {
        SEXP nn = getAttrib(x, install("row.names"));

        if (isInteger(nn)) {
            nn = PROTECT(coerceVector(nn, STRSXP));
            msg = check_names(x, nn, row_names, "Rows");
            UNPROTECT(1);
        } else {
            msg = check_names(x, nn, row_names, "Rows");
        }
        if (!msg.ok)
            return mwrap(msg);
    }

    if (!isNull(col_names)) {
        msg = check_names(x, getAttrib(x, R_NamesSymbol), col_names, "Columns");
        if (!msg.ok)
            return mwrap(msg);
    }
    return ScalarLogical(TRUE);
}

SEXP c_check_factor(SEXP x, SEXP any_missing, SEXP all_missing, SEXP len, SEXP min_len, SEXP max_len, SEXP unique, SEXP names) {
    if (!isFactor(x) && !all_missing_atomic(x))
        return CheckResult("Must be a factor");
    return mwrap(check_vector_props(x, any_missing, all_missing, len, min_len, max_len, unique, names));
}

SEXP c_check_integer(SEXP x, SEXP lower, SEXP upper, SEXP any_missing, SEXP all_missing, SEXP len, SEXP min_len, SEXP max_len, SEXP unique, SEXP names) {
    if (!isInteger(x) && !all_missing_atomic(x))
        return CheckResult("Must be integer");
    msg_t msg = check_bounds(x, lower, upper);
    if (!msg.ok)
        return mwrap(msg);
    return mwrap(check_vector_props(x, any_missing, all_missing, len, min_len, max_len, unique, names));
}

SEXP c_check_integerish(SEXP x, SEXP tol, SEXP lower, SEXP upper, SEXP any_missing, SEXP all_missing, SEXP len, SEXP min_len, SEXP max_len, SEXP unique, SEXP names) {
    if (!isIntegerish(x, asTol(tol)) && !all_missing_atomic(x))
        return CheckResult("Must be integerish");

    msg_t msg = check_bounds(x, lower, upper);
    if (!msg.ok)
        return mwrap(msg);
    return mwrap(check_vector_props(x, any_missing, all_missing, len, min_len, max_len, unique, names));
}

SEXP c_check_list(SEXP x, SEXP any_missing, SEXP all_missing, SEXP len, SEXP min_len, SEXP max_len, SEXP unique, SEXP names) {
    if (!isNewList(x) || isFrame(x) || isNull(x))
        return CheckResult("Must be a list");
    return mwrap(check_vector_props(x, any_missing, all_missing, len, min_len, max_len, unique, names));
}

SEXP c_check_logical(SEXP x, SEXP any_missing, SEXP all_missing, SEXP len, SEXP min_len, SEXP max_len, SEXP unique, SEXP names) {
    if (!isLogical(x) && !all_missing_atomic(x))
        return CheckResult("Must be logical");
    return mwrap(check_vector_props(x, any_missing, all_missing, len, min_len, max_len, unique, names));
}

SEXP c_check_matrix(SEXP x, SEXP mode, SEXP any_missing, SEXP min_rows, SEXP min_cols, SEXP rows, SEXP cols, SEXP row_names, SEXP col_names) {
    if (!isMatrix(x))
        return CheckResult("Must be a matrix");

    msg_t msg = check_storage(x, mode);
    if (!msg.ok)
        return mwrap(msg);

    msg = check_matrix_props(x, any_missing, min_rows, min_cols, rows, cols);
    if (!msg.ok)
        return mwrap(msg);

    if (!isNull(row_names)) {
        SEXP nn = getAttrib(x, R_DimNamesSymbol);
        if (!isNull(nn))
            nn = VECTOR_ELT(nn, 0);
        msg = check_names(x, nn, row_names, "Rows");
        if (!msg.ok)
            return mwrap(msg);
    }

    if (!isNull(col_names) && length(x) > 0) {
        SEXP nn = getAttrib(x, R_DimNamesSymbol);
        if (!isNull(nn))
            nn = VECTOR_ELT(nn, 1);
        msg = check_names(x, nn, col_names, "Columns");
        if (!msg.ok)
            return mwrap(msg);
    }

    return ScalarLogical(TRUE);
}

SEXP c_check_array(SEXP x, SEXP mode, SEXP any_missing, SEXP d) {
    if (!isArray(x))
        return CheckResult("Must be an array");
    msg_t msg = check_storage(x, mode);
    if (!msg.ok)
        return mwrap(msg);
    return mwrap(check_array_props(x, any_missing, d));
}

SEXP c_check_named(SEXP x, SEXP type) {
    if (!isNull(type))
        return mwrap(check_names(x, getAttrib(x, R_NamesSymbol), type, "Object"));
    return ScalarLogical(TRUE);
}

SEXP c_check_names(SEXP x, SEXP type) {
    if (!isString(x))
        return CheckResult("Must be a character vector of names");
    name_t res = check_type(x, get_name_type(type));
    switch(res) {
        case T_UNDEF: break;
        case T_UNNAMED: return CheckResult("Names must be missing (NULL)");
        case T_NAMED: return CheckResult("Valid names required");
        case T_UNIQUE: return CheckResult("All names must be unique");
        case T_STRICT: return CheckResult("All names must comply to R's variable naming rules");
    }
    return ScalarLogical(TRUE);
}

SEXP c_check_numeric(SEXP x, SEXP lower, SEXP upper, SEXP finite, SEXP any_missing, SEXP all_missing, SEXP len, SEXP min_len, SEXP max_len, SEXP unique, SEXP names) {
    if (!isNumeric(x) && !all_missing_atomic(x))
        return CheckResult("Must be numeric");
    if (asFlag(finite, "finite") && any_infinite(x))
        return CheckResult("Must be finite");
    msg_t msg = check_bounds(x, lower, upper);
    if (!msg.ok)
        return mwrap(msg);
    return mwrap(check_vector_props(x, any_missing, all_missing, len, min_len, max_len, unique, names));
}

SEXP c_check_vector(SEXP x, SEXP strict, SEXP any_missing, SEXP all_missing, SEXP len, SEXP min_len, SEXP max_len, SEXP unique, SEXP names) {
    if (!isVector(x) || ((asFlag(strict, "strict") && !is_vector(x))))
        return CheckResult("Must be a vector");
    return mwrap(check_vector_props(x, any_missing, all_missing, len, min_len, max_len, unique, names));
}

SEXP c_check_atomic(SEXP x, SEXP any_missing, SEXP all_missing, SEXP len, SEXP min_len, SEXP max_len, SEXP unique, SEXP names) {
    if (!isNull(x) && !isVectorAtomic(x))
        return CheckResult("Must be atomic");
    return mwrap(check_vector_props(x, any_missing, all_missing, len, min_len, max_len, unique, names));
}

SEXP c_check_atomic_vector(SEXP x, SEXP any_missing, SEXP all_missing, SEXP len, SEXP min_len, SEXP max_len, SEXP unique, SEXP names) {
    if (!isVectorAtomic(x))
        return CheckResult("Must be an atomic vector");
    return mwrap(check_vector_props(x, any_missing, all_missing, len, min_len, max_len, unique, names));
}

/*********************************************************************************************************************/
/* Check functions for scalars                                                                                       */
/*********************************************************************************************************************/
SEXP c_check_flag(SEXP x, SEXP na_ok) {
    Rboolean is_na = is_scalar_na(x);
    if (length(x) != 1 || (!is_na && !isLogical(x)))
        return CheckResult("Must be a logical flag");
    if (is_na && !asFlag(na_ok, "na.ok"))
        return CheckResult("May not be NA");
    return ScalarLogical(TRUE);
}

SEXP c_check_count(SEXP x, SEXP na_ok, SEXP positive, SEXP tol) {
    Rboolean is_na = is_scalar_na(x);
    if (length(x) != 1 || (!is_na && !isIntegerish(x, asTol(tol))))
        return CheckResult("Must be a count");
    if (is_na) {
        if (!asFlag(na_ok, "na.ok"))
            return CheckResult("May not be NA");
    } else  {
        const int pos = (int) asFlag(positive, "positive");
        if (asInteger(x) < pos)
            return CheckResultf("Must be >= %i", pos);
    }
    return ScalarLogical(TRUE);
}

SEXP c_check_int(SEXP x, SEXP na_ok, SEXP lower, SEXP upper, SEXP tol) {
    Rboolean is_na = is_scalar_na(x);
    if (length(x) != 1 || (!is_na && !isIntegerish(x, asTol(tol))))
        return CheckResult("Must be a single integerish value");
    if (is_na) {
        if (!asFlag(na_ok, "na.ok"))
            return CheckResult("May not be NA");
    }
    return mwrap(check_bounds(x, lower, upper));
}

SEXP c_check_number(SEXP x, SEXP na_ok, SEXP lower, SEXP upper, SEXP finite) {
    Rboolean is_na = is_scalar_na(x);
    if (length(x) != 1 || (!is_na && !isStrictlyNumeric(x)))
        return CheckResult("Must be a number");
    if (is_na) {
        if (!asFlag(na_ok, "na.ok"))
            return CheckResult("May not be NA");
        return ScalarLogical(TRUE);
    }
    if (asFlag(finite, "finite") && any_infinite(x))
        return CheckResult("Must be finite");
    return mwrap(check_bounds(x, lower, upper));
}

SEXP c_check_string(SEXP x, SEXP na_ok) {
    Rboolean is_na = is_scalar_na(x);
    if (length(x) != 1 || (!is_na && !isString(x)))
        return CheckResult("Must be a string");
    if (is_na && !asFlag(na_ok, "na.ok"))
        return CheckResult("May not be NA");
    return ScalarLogical(TRUE);
}

SEXP c_check_scalar(SEXP x, SEXP na_ok) {
    Rboolean is_na = is_scalar_na(x);
    if (length(x) != 1 || (!is_na && !isVectorAtomic(x)))
        return CheckResult("Must be an atomic scalar");
    if (is_na && !asFlag(na_ok, "na.ok"))
        return CheckResult("May not be NA");
    return ScalarLogical(TRUE);
}
