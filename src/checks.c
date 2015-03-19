#include "checks.h"
#include <ctype.h>
#include <string.h>
#include "cmessages.h"
#include "is_integerish.h"
#include "any_missing.h"
#include "any_infinite.h"
#include "all_missing.h"
#include "all_nchar.h"
#include "helper.h"


/*********************************************************************************************************************/
/* Some helpers                                                                                                      */
/*********************************************************************************************************************/
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

static msg_t check_bounds(SEXP x, SEXP lower, SEXP upper) {
    double tmp;

    tmp = asNumber(lower, "lower");
    if (R_FINITE(tmp)) {
        if (isReal(x)) {
            const double *xp = REAL(x);
            const double * const xend = xp + length(x);
            for (; xp != xend; xp++) {
                if (!ISNAN(*xp) && *xp < tmp)
                    return make_msg("All elements must be >= %g", tmp);
            }
        } else if (isInteger(x)) {
            const int *xp = INTEGER(x);
            const int * const xend = xp + length(x);
            for (; xp != xend; xp++) {
                if (*xp != NA_INTEGER && *xp < tmp)
                    return make_msg("All elements must be >= %g", tmp);
            }
        } else {
            error("Bound checks only possible for numeric variables");
        }
    }

    tmp = asNumber(upper, "upper");
    if (R_FINITE(tmp)) {
        if (isReal(x)) {
            const double *xp = REAL(x);
            const double * const xend = xp + length(x);
            for (; xp != xend; xp++) {
                if (!ISNAN(*xp) && *xp > tmp)
                    return make_msg("All elements must be <= %g", tmp);
            }
        } else if (isInteger(x)) {
            const int *xp = INTEGER(x);
            const int * const xend = xp + length(x);
            for (; xp != xend; xp++) {
                if (*xp != NA_INTEGER && *xp > tmp)
                    return make_msg("All elements must be <= %g", tmp);
            }
        } else {
            error("Bound checks only possible for numeric variables");
        }
    }
    return MSGT;
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

static msg_t check_names(SEXP nn, SEXP type, const char * what) {
    typedef enum { T_NAMED, T_UNIQUE, T_STRICT } name_t;
    const char * expected = asString(type, "names");

    if (strcmp(expected, "unnamed") == 0) {
        if (isNull(nn))
            return MSGT;
        return make_msg("%s must be unnamed, but has names", what);
    }

    name_t checks;
    if (strcmp(expected, "named") == 0) {
        checks = T_NAMED;
    } else if (strcmp(expected, "unique") == 0) {
        checks = T_UNIQUE;
    } else if (strcmp(expected, "strict") == 0) {
        checks = T_STRICT;
    } else {
        error("Unknown type definition '%s'", expected);
    }

    if (!check_valid_names(nn))
        return make_msg("%s must be named", what);
    if (checks >= T_UNIQUE) {
        if (!check_unique_names(nn))
            return make_msg("%s must be uniquely named", what);
        if (checks == T_STRICT && !check_strict_names(nn))
            return make_msg("%s must be named according to R's variable naming rules", what);
    }

    return MSGT;
}

static msg_t check_vector_props(SEXP x, SEXP any_missing, SEXP all_missing, SEXP len, SEXP min_len, SEXP max_len, SEXP unique, SEXP names) {
    if (!isNull(len)) {
        R_len_t n = asCount(len, "len");
        if (length(x) != n)
            return make_msg("Must have length %i, but has length %i", n, length(x));
    }

    if (!isNull(min_len)) {
        R_len_t n = asCount(min_len, "min.len");
        if (length(x) < n)
            return make_msg("Must have length >= %i, but has length %i", n, length(x));
    }

    if (!isNull(max_len)) {
        R_len_t n = asCount(max_len, "max.len");
        if (length(x) > n)
            return make_msg("Must have length <= %i, but has length %i", n, length(x));
    }

    if (!asFlag(any_missing, "any.missing") && any_missing_atomic(x))
        return make_msg("Contains missing values");

    if (!asFlag(all_missing, "all.missing") && all_missing_atomic(x))
        return make_msg("Contains only missing values");

    if (asFlag(unique, "unique") && any_duplicated(x, FALSE) > 0)
        return make_msg("Contains duplicated values");

    if (!isNull(names) && length(x) > 0)
        return check_names(getAttrib(x, R_NamesSymbol), names, "Vector");
    return MSGT;
}

static msg_t check_matrix_props(SEXP x, SEXP any_missing, SEXP min_rows, SEXP min_cols, SEXP rows, SEXP cols) {
    if (!isNull(min_rows) || !isNull(rows)) {
        R_len_t xrows = get_nrows(x);
        if (!isNull(min_rows)) {
            R_len_t cmp = asCount(min_rows, "min.rows");
            if (xrows < cmp)
                return make_msg("Must have at least %i rows, but has %i rows", cmp, xrows);
        }
        if (!isNull(rows)) {
            R_len_t cmp = asCount(rows, "rows");
            if (xrows != cmp)
                return make_msg("Must have exactly %i rows, but has %i rows", cmp, xrows);
        }
    }
    if (!isNull(min_cols) || !isNull(cols)) {
        R_len_t xcols = get_ncols(x);
        if (!isNull(min_cols)) {
            R_len_t cmp = asCount(min_cols, "min.cols");
            if (xcols < cmp)
                return make_msg("Must have at least %i cols, but has %i cols", cmp, xcols);
        }
        if (!isNull(cols)) {
            R_len_t cmp = asCount(cols, "cols");
            if (xcols != cmp)
                return make_msg("Must have exactly %i cols, but has %i cols", cmp, xcols);
        }
    }

    if (!asFlag(any_missing, "any.missing") && any_missing_atomic(x))
        return make_msg("Contains missing values");

    return MSGT;
}

static msg_t check_storage(SEXP x, SEXP mode) {
    if (!isNull(mode)) {
        const char * const storage = asString(mode, "mode");
        if (strcmp(storage, "logical") == 0) {
            if (!isLogical(x))
                return make_msg("Must contain logicals");
        } else if (strcmp(storage, "integer") == 0) {
            if (!isInteger(x))
                return make_msg("Must contain integers");
        } else if (strcmp(storage, "double") == 0) {
            if (!isReal(x))
                return make_msg("Must contain doubles");
        } else if (strcmp(storage, "numeric") == 0) {
            if (!isStrictlyNumeric(x))
                return make_msg("Must contain numerics");
        } else if (strcmp(storage, "complex") == 0) {
            if (!isComplex(x))
                return make_msg("Must contain complexs");
        } else if (strcmp(storage, "character") == 0) {
            if (!isString(x))
                return make_msg("Must contain characters");
        } else {
            error("Invalid argument 'mode'. Must be one of 'logical', 'integer', 'double', 'numeric', 'complex' or 'character'");
        }
    }
    return MSGT;
}

static msg_t check_array_props(SEXP x, SEXP any_missing, SEXP d) {
    if (!isNull(d)) {
        int di = asCount(d, "d");
        R_len_t ndim = length(getAttrib(x, R_DimSymbol));
        if (ndim != di)
            return make_msg("Must be a %i-d array, but has dimension %i", di, ndim);
    }
    if (!asFlag(any_missing, "any.missing") && any_missing_atomic(x))
        return make_msg("Contains missing values");

    return MSGT;
}


/*********************************************************************************************************************/
/* Exported check functions                                                                                          */
/*********************************************************************************************************************/
SEXP c_check_character(SEXP x, SEXP min_chars, SEXP any_missing, SEXP all_missing, SEXP len, SEXP min_len, SEXP max_len, SEXP unique, SEXP names) {
    if (!isString(x) && !all_missing_atomic(x))
        return make_type_error(x, "character");
    if (!isNull(min_chars)) {
        R_len_t n = asCount(min_chars, "min.chars");
        if (n > 0 && !all_nchar(x, n))
            return make_result("All elements must have at least %i characters", n);
    }
    return mwrap(check_vector_props(x, any_missing, all_missing, len, min_len, max_len, unique, names));
}

SEXP c_check_complex(SEXP x, SEXP any_missing, SEXP all_missing, SEXP len, SEXP min_len, SEXP max_len, SEXP unique, SEXP names) {
    if (!isComplex(x) && !all_missing_atomic(x))
        return make_type_error(x, "complex");
    return mwrap(check_vector_props(x, any_missing, all_missing, len, min_len, max_len, unique, names));
}

SEXP c_check_dataframe(SEXP x, SEXP any_missing, SEXP min_rows, SEXP min_cols, SEXP rows, SEXP cols, SEXP row_names, SEXP col_names) {
    if (!isFrame(x))
        return make_type_error(x, "data.frame");

    msg_t msg = check_matrix_props(x, any_missing, min_rows, min_cols, rows, cols);
    if (!msg.ok)
        return make_result(msg.msg);

    if (!isNull(row_names)) {
        SEXP nn = getAttrib(x, install("row.names"));

        if (isInteger(nn)) {
            nn = PROTECT(coerceVector(nn, STRSXP));
            msg = check_names(nn, row_names, "Rows");
            UNPROTECT(1);
        } else {
            msg = check_names(nn, row_names, "Rows");
        }
        if (!msg.ok)
            return make_result(msg.msg);
    }

    if (!isNull(col_names)) {
        msg = check_names(getAttrib(x, R_NamesSymbol), col_names, "Columns");
        if (!msg.ok)
            return make_result(msg.msg);
    }

    return ScalarLogical(TRUE);
}

SEXP c_check_factor(SEXP x, SEXP any_missing, SEXP all_missing, SEXP len, SEXP min_len, SEXP max_len, SEXP unique, SEXP names) {
    if (!isFactor(x) && !all_missing_atomic(x))
        return make_type_error(x, "factor");
    return mwrap(check_vector_props(x, any_missing, all_missing, len, min_len, max_len, unique, names));
}

SEXP c_check_integer(SEXP x, SEXP lower, SEXP upper, SEXP any_missing, SEXP all_missing, SEXP len, SEXP min_len, SEXP max_len, SEXP unique, SEXP names) {
    if (!isInteger(x) && !all_missing_atomic(x))
        return make_type_error(x, "integer");
    msg_t msg = check_bounds(x, lower, upper);
    if (!msg.ok)
        return make_result(msg.msg);
    return mwrap(check_vector_props(x, any_missing, all_missing, len, min_len, max_len, unique, names));
}

SEXP c_check_integerish(SEXP x, SEXP tol, SEXP lower, SEXP upper, SEXP any_missing, SEXP all_missing, SEXP len, SEXP min_len, SEXP max_len, SEXP unique, SEXP names) {
    if (!isIntegerish(x, asTol(tol)) && !all_missing_atomic(x))
        return make_type_error(x, "integerish");

    msg_t msg = check_bounds(x, lower, upper);
    if (!msg.ok)
        return make_result(msg.msg);
    return mwrap(check_vector_props(x, any_missing, all_missing, len, min_len, max_len, unique, names));
}

SEXP c_check_list(SEXP x, SEXP any_missing, SEXP all_missing, SEXP len, SEXP min_len, SEXP max_len, SEXP unique, SEXP names) {
    if (!isNewList(x) || isFrame(x) || isNull(x))
        return make_type_error(x, "list");
    return mwrap(check_vector_props(x, any_missing, all_missing, len, min_len, max_len, unique, names));
}

SEXP c_check_logical(SEXP x, SEXP any_missing, SEXP all_missing, SEXP len, SEXP min_len, SEXP max_len, SEXP unique, SEXP names) {
    if (!isLogical(x) && !all_missing_atomic(x))
        return make_type_error(x, "logical");
    return mwrap(check_vector_props(x, any_missing, all_missing, len, min_len, max_len, unique, names));
}

SEXP c_check_matrix(SEXP x, SEXP mode, SEXP any_missing, SEXP min_rows, SEXP min_cols, SEXP rows, SEXP cols, SEXP row_names, SEXP col_names) {
    if (!isMatrix(x))
        return make_type_error(x, "matrix");

    msg_t msg = check_storage(x, mode);
    if (!msg.ok)
        return make_result(msg.msg);

    msg = check_matrix_props(x, any_missing, min_rows, min_cols, rows, cols);
    if (!msg.ok)
        return make_result(msg.msg);

    if (!isNull(row_names) && length(x) > 0) {
        SEXP nn = getAttrib(x, R_DimNamesSymbol);
        if (!isNull(nn))
            nn = VECTOR_ELT(nn, 0);
        msg = check_names(nn, row_names, "Rows");
        if (!msg.ok)
            return make_result(msg.msg);
    }

    if (!isNull(col_names) && length(x) > 0) {
        SEXP nn = getAttrib(x, R_DimNamesSymbol);
        if (!isNull(nn))
            nn = VECTOR_ELT(nn, 1);
        msg = check_names(nn, col_names, "Columns");
        if (!msg.ok)
            return make_result(msg.msg);
    }

    return ScalarLogical(TRUE);
}

SEXP c_check_array(SEXP x, SEXP mode, SEXP any_missing, SEXP d) {
    if (!isArray(x))
        return make_type_error(x, "array");
    msg_t msg = check_storage(x, mode);
    if (!msg.ok)
        return make_result(msg.msg);
    return mwrap(check_array_props(x, any_missing, d));
}

SEXP c_check_named(SEXP x, SEXP type) {
    if (!isNull(type) && length(x) > 0)
        return mwrap(check_names(getAttrib(x, R_NamesSymbol), type, "Object"));
    return ScalarLogical(TRUE);
}

SEXP c_check_names(SEXP x, SEXP type) {
    if (!isString(x))
        return make_result("Must be a character vector of names");
    return mwrap(check_names(x, type, "Object"));
}

SEXP c_check_numeric(SEXP x, SEXP lower, SEXP upper, SEXP finite, SEXP any_missing, SEXP all_missing, SEXP len, SEXP min_len, SEXP max_len, SEXP unique, SEXP names) {
    if (!isNumeric(x) && !all_missing_atomic(x))
        return make_type_error(x, "numeric");
    if (asFlag(finite, "finite") && any_infinite(x))
        return make_result("Must be finite");
    msg_t msg = check_bounds(x, lower, upper);
    if (!msg.ok)
        return make_result(msg.msg);
    return mwrap(check_vector_props(x, any_missing, all_missing, len, min_len, max_len, unique, names));
}

SEXP c_check_vector(SEXP x, SEXP strict, SEXP any_missing, SEXP all_missing, SEXP len, SEXP min_len, SEXP max_len, SEXP unique, SEXP names) {
    if (!isVector(x) || ((asFlag(strict, "strict") && !is_vector(x))))
        return make_type_error(x, "vector");
    return mwrap(check_vector_props(x, any_missing, all_missing, len, min_len, max_len, unique, names));
}

SEXP c_check_atomic(SEXP x, SEXP any_missing, SEXP all_missing, SEXP len, SEXP min_len, SEXP max_len, SEXP unique, SEXP names) {
    if (!isNull(x) && !isVectorAtomic(x))
        return make_type_error(x, "atomic");
    return mwrap(check_vector_props(x, any_missing, all_missing, len, min_len, max_len, unique, names));
}

SEXP c_check_atomic_vector(SEXP x, SEXP any_missing, SEXP all_missing, SEXP len, SEXP min_len, SEXP max_len, SEXP unique, SEXP names) {
    if (!isVectorAtomic(x))
        return make_type_error(x, "atomic vector");
    return mwrap(check_vector_props(x, any_missing, all_missing, len, min_len, max_len, unique, names));
}

/*********************************************************************************************************************/
/* Check functions for scalars                                                                                       */
/*********************************************************************************************************************/
SEXP c_check_flag(SEXP x, SEXP na_ok) {
    Rboolean is_na = is_scalar_na(x);
    if (length(x) != 1 || (!is_na && !isLogical(x)))
        return make_type_error(x, "logical flag");
    if (is_na && !asFlag(na_ok, "na.ok"))
        return make_result("May not be NA");
    return ScalarLogical(TRUE);
}

SEXP c_check_count(SEXP x, SEXP na_ok, SEXP positive, SEXP tol) {
    Rboolean is_na = is_scalar_na(x);
    if (length(x) != 1 || (!is_na && !isIntegerish(x, asTol(tol))))
        return make_type_error(x, "count");
    if (is_na) {
        if (!asFlag(na_ok, "na.ok"))
            return make_result("May not be NA");
    } else  {
        const int pos = (int) asFlag(positive, "positive");
        if (asInteger(x) < pos)
            return make_result("Must be >= %i", pos);
    }
    return ScalarLogical(TRUE);
}

SEXP c_check_int(SEXP x, SEXP na_ok, SEXP lower, SEXP upper, SEXP tol) {
    Rboolean is_na = is_scalar_na(x);
    if (length(x) != 1 || (!is_na && !isIntegerish(x, asTol(tol))))
        return make_type_error(x, "single integerish value");
    if (is_na) {
        if (!asFlag(na_ok, "na.ok"))
            return make_result("May not be NA");
    }
    return mwrap(check_bounds(x, lower, upper));
}

SEXP c_check_number(SEXP x, SEXP na_ok, SEXP lower, SEXP upper, SEXP finite) {
    Rboolean is_na = is_scalar_na(x);
    if (length(x) != 1 || (!is_na && !isStrictlyNumeric(x)))
        return make_type_error(x, "number");
    if (is_na) {
        if (!asFlag(na_ok, "na.ok"))
            return make_result("May not be NA");
        return ScalarLogical(TRUE);
    }
    if (asFlag(finite, "finite") && any_infinite(x))
        return make_result("Must be finite");
    return mwrap(check_bounds(x, lower, upper));
}

SEXP c_check_string(SEXP x, SEXP na_ok) {
    Rboolean is_na = is_scalar_na(x);
    if (length(x) != 1 || (!is_na && !isString(x)))
        return make_type_error(x, "string");
    if (is_na && !asFlag(na_ok, "na.ok"))
        return make_result("May not be NA");
    return ScalarLogical(TRUE);
}

SEXP c_check_scalar(SEXP x, SEXP na_ok) {
    Rboolean is_na = is_scalar_na(x);
    if (length(x) != 1 || (!is_na && !isVectorAtomic(x)))
        return make_type_error(x, "atomic scalar");
    if (is_na && !asFlag(na_ok, "na.ok"))
        return make_result("May not be NA");
    return ScalarLogical(TRUE);
}
