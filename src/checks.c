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

#define assert(x) ({ msg_t tmp = x; if (!tmp.ok) return ScalarString(mkChar(tmp.msg)); })

/*********************************************************************************************************************/
/* Some helpers                                                                                                      */
/*********************************************************************************************************************/
static msg_t check_bounds(SEXP x, SEXP lower, SEXP upper) {
    double tmp;

    tmp = asNumber(lower, "lower");
    if (R_FINITE(tmp)) {
        if (isReal(x)) {
            const double *xp = REAL(x);
            const double * const xend = xp + xlength(x);
            for (; xp != xend; xp++) {
                if (!ISNAN(*xp) && *xp < tmp)
                    return make_msg("All elements must be >= %g", tmp);
            }
        } else if (isInteger(x)) {
            const int *xp = INTEGER(x);
            const int * const xend = xp + xlength(x);
            for (; xp != xend; xp++) {
                if (*xp != NA_INTEGER && *xp < tmp)
                    return make_msg("All elements must be >= %g", tmp);
            }
        }
    }

    tmp = asNumber(upper, "upper");
    if (R_FINITE(tmp)) {
        if (isReal(x)) {
            const double *xp = REAL(x);
            const double * const xend = xp + xlength(x);
            for (; xp != xend; xp++) {
                if (!ISNAN(*xp) && *xp > tmp)
                    return make_msg("All elements must be <= %g", tmp);
            }
        } else if (isInteger(x)) {
            const int *xp = INTEGER(x);
            const int * const xend = xp + xlength(x);
            for (; xp != xend; xp++) {
                if (*xp != NA_INTEGER && *xp > tmp)
                    return make_msg("All elements must be <= %g", tmp);
            }
        }
    }
    return MSGT;
}

static Rboolean check_strict_names(SEXP x) {
    const R_xlen_t nx = xlength(x);
    const char *str;
    for (R_xlen_t i = 0; i < nx; i++) {
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
        error("Unknown type '%s' to specify check for names. Supported are 'unnamed', 'named', 'unique' and 'strict'.", expected);
    }

    if (isNull(nn) || any_missing_string(nn) || !all_nchar(nn, 1))
        return make_msg("%s must be named", what);
    if (checks >= T_UNIQUE) {
        if (any_duplicated(nn, FALSE) != 0)
            return make_msg("%s must be uniquely named", what);
        if (checks >= T_STRICT && !check_strict_names(nn))
            return make_msg("%s must be named according to R's variable naming rules", what);
    }
    return MSGT;
}


static msg_t check_min_chars(SEXP x, SEXP min_chars) {
    if (!isNull(min_chars)) {
        R_xlen_t n = asCount(min_chars, "min.chars");
        if (n > 0 && !all_nchar(x, n))
            return make_msg("All elements must have at least %g characters", (double)n);
    }
    return MSGT;
}

static msg_t check_vector_len(SEXP x, SEXP len, SEXP min_len, SEXP max_len) {
    if (!isNull(len)) {
        R_xlen_t n = asCount(len, "len");
        if (xlength(x) != n)
            return make_msg("Must have length %g, but has length %g", (double)n, (double)xlength(x));
    }
    if (!isNull(min_len)) {
        R_xlen_t n = asCount(min_len, "min.len");
        if (xlength(x) < n)
            return make_msg("Must have length >= %g, but has length %g", (double)n, (double)xlength(x));
    }
    if (!isNull(max_len)) {
        R_xlen_t n = asCount(max_len, "max.len");
        if (xlength(x) > n)
            return make_msg("Must have length <= %g, but has length %g", (double)n, (double)xlength(x));
    }
    return MSGT;
}

static msg_t check_vector_missings(SEXP x, SEXP any_missing, SEXP all_missing) {
    if (!asFlag(any_missing, "any.missing") && any_missing_atomic(x))
        return make_msg("Contains missing values");
    if (!asFlag(all_missing, "all.missing") && all_missing_atomic(x))
        return make_msg("Contains only missing values");
    return MSGT;
}

static msg_t check_vector_unique(SEXP x, SEXP unique) {
    if (asFlag(unique, "unique") && any_duplicated(x, FALSE) > 0)
        return make_msg("Contains duplicated values");
    return MSGT;
}

static msg_t check_vector_names(SEXP x, SEXP names) {
    if (!isNull(names) && xlength(x) > 0)
        return check_names(getAttrib(x, R_NamesSymbol), names, "Vector");
    return MSGT;
}

static msg_t check_vector_finite(SEXP x, SEXP finite) {
    if (asFlag(finite, "finite") && any_infinite(x))
        return make_msg("Must be finite");
    return MSGT;
}

static msg_t check_matrix_dims(SEXP x, SEXP min_rows, SEXP min_cols, SEXP rows, SEXP cols) {
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
    return MSGT;
}

static msg_t check_storage(SEXP x, SEXP mode) {
    if (!isNull(mode)) {
        const char * const storage = asString(mode, "mode");
        if (strcmp(storage, "logical") == 0) {
            if (!isLogical(x))
                return make_msg("Must store logicals");
        } else if (strcmp(storage, "integer") == 0) {
            if (!isInteger(x))
                return make_msg("Must store integers");
        } else if (strcmp(storage, "double") == 0) {
            if (!isReal(x))
                return make_msg("Must store doubles");
        } else if (strcmp(storage, "numeric") == 0) {
            if (!isStrictlyNumeric(x))
                return make_msg("Must store numerics");
        } else if (strcmp(storage, "complex") == 0) {
            if (!isComplex(x))
                return make_msg("Must store complexs");
        } else if (strcmp(storage, "character") == 0) {
            if (!isString(x))
                return make_msg("Must store characters");
        } else if (strcmp(storage, "list") == 0) {
            if (!isRList(x))
                return make_msg("Must store a list");
        } else if (strcmp(storage, "atomic") == 0) {
            if (!isVectorAtomic(x))
                return make_msg("Must be atomic");
        } else {
            error("Invalid argument 'mode'. Must be one of 'logical', 'integer', 'double', 'numeric', 'complex', 'character', 'list' or 'atomic'");
        }
    }
    return MSGT;
}

/*********************************************************************************************************************/
/* Exported check functions                                                                                          */
/*********************************************************************************************************************/
SEXP c_check_character(SEXP x, SEXP min_chars, SEXP any_missing, SEXP all_missing, SEXP len, SEXP min_len, SEXP max_len, SEXP unique, SEXP names) {
    if (!isString(x) && !all_missing_atomic(x))
        return make_type_error(x, "character");
    assert(check_vector_len(x, len, min_len, max_len));
    assert(check_vector_names(x, names));
    assert(check_vector_missings(x, any_missing, all_missing));
    assert(check_min_chars(x, min_chars));
    assert(check_vector_unique(x, unique));
    return ScalarLogical(TRUE);
}

SEXP c_check_complex(SEXP x, SEXP any_missing, SEXP all_missing, SEXP len, SEXP min_len, SEXP max_len, SEXP unique, SEXP names) {
    if (!isComplex(x) && !all_missing_atomic(x))
        return make_type_error(x, "complex");
    assert(check_vector_len(x, len, min_len, max_len));
    assert(check_vector_names(x, names));
    assert(check_vector_missings(x, any_missing, all_missing));
    assert(check_vector_unique(x, unique));
    return ScalarLogical(TRUE);
}

SEXP c_check_dataframe(SEXP x, SEXP any_missing, SEXP all_missing, SEXP min_rows, SEXP min_cols, SEXP rows, SEXP cols, SEXP row_names, SEXP col_names) {
    if (!isFrame(x))
        return make_type_error(x, "data.frame");
    assert(check_matrix_dims(x, min_rows, min_cols, rows, cols));

    if (!isNull(row_names)) {
        SEXP nn = getAttrib(x, install("row.names"));
        msg_t msg;

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

    if (!isNull(col_names))
        assert(check_names(getAttrib(x, R_NamesSymbol), col_names, "Columns"));
    if (!asFlag(any_missing, "any.missing") && any_missing_frame(x))
        return make_result("Contains missing values");
    if (!asFlag(all_missing, "all.missing") && all_missing_frame(x))
        return make_result("Contains only missing values");
    return ScalarLogical(TRUE);
}

SEXP c_check_factor(SEXP x, SEXP any_missing, SEXP all_missing, SEXP len, SEXP min_len, SEXP max_len, SEXP unique, SEXP names) {
    if (!isFactor(x) && !all_missing_atomic(x))
        return make_type_error(x, "factor");
    assert(check_vector_len(x, len, min_len, max_len));
    assert(check_vector_names(x, names));
    assert(check_vector_missings(x, any_missing, all_missing));
    assert(check_vector_unique(x, unique));
    return ScalarLogical(TRUE);
}

SEXP c_check_integer(SEXP x, SEXP lower, SEXP upper, SEXP any_missing, SEXP all_missing, SEXP len, SEXP min_len, SEXP max_len, SEXP unique, SEXP names) {
    if (!isInteger(x) && !all_missing_atomic(x))
        return make_type_error(x, "integer");
    assert(check_vector_len(x, len, min_len, max_len));
    assert(check_vector_names(x, names));
    assert(check_vector_missings(x, any_missing, all_missing));
    assert(check_bounds(x, lower, upper));
    assert(check_vector_unique(x, unique));
    return ScalarLogical(TRUE);
}

SEXP c_check_integerish(SEXP x, SEXP tol, SEXP lower, SEXP upper, SEXP any_missing, SEXP all_missing, SEXP len, SEXP min_len, SEXP max_len, SEXP unique, SEXP names) {
    double dtol = asNumber(tol, "tol");
    if (!isIntegerish(x, dtol) && !all_missing_atomic(x))
        return make_type_error(x, "integerish");
    assert(check_vector_len(x, len, min_len, max_len));
    assert(check_vector_names(x, names));
    assert(check_vector_missings(x, any_missing, all_missing));
    assert(check_bounds(x, lower, upper));
    assert(check_vector_unique(x, unique));
    return ScalarLogical(TRUE);
}

SEXP c_check_list(SEXP x, SEXP any_missing, SEXP all_missing, SEXP len, SEXP min_len, SEXP max_len, SEXP unique, SEXP names) {
    if (!isRList(x))
        return make_type_error(x, "list");
    assert(check_vector_len(x, len, min_len, max_len));
    assert(check_vector_names(x, names));
    assert(check_vector_missings(x, any_missing, all_missing));
    assert(check_vector_unique(x, unique));
    return ScalarLogical(TRUE);
}

SEXP c_check_logical(SEXP x, SEXP any_missing, SEXP all_missing, SEXP len, SEXP min_len, SEXP max_len, SEXP unique, SEXP names) {
    if (!isLogical(x) && !all_missing_atomic(x))
        return make_type_error(x, "logical");
    assert(check_vector_len(x, len, min_len, max_len));
    assert(check_vector_names(x, names));
    assert(check_vector_missings(x, any_missing, all_missing));
    assert(check_vector_unique(x, unique));
    return ScalarLogical(TRUE);
}

SEXP c_check_matrix(SEXP x, SEXP mode, SEXP any_missing, SEXP all_missing, SEXP min_rows, SEXP min_cols, SEXP rows, SEXP cols, SEXP row_names, SEXP col_names) {
    if (!isMatrix(x))
        return make_type_error(x, "matrix");
    assert(check_storage(x, mode));
    assert(check_matrix_dims(x, min_rows, min_cols, rows, cols));

    if (!isNull(row_names) && xlength(x) > 0) {
        SEXP nn = getAttrib(x, R_DimNamesSymbol);
        if (!isNull(nn))
            nn = VECTOR_ELT(nn, 0);
        assert(check_names(nn, row_names, "Rows"));
    }

    if (!isNull(col_names) && xlength(x) > 0) {
        SEXP nn = getAttrib(x, R_DimNamesSymbol);
        if (!isNull(nn))
            nn = VECTOR_ELT(nn, 1);
        assert(check_names(nn, col_names, "Columns"));
    }
    assert(check_vector_missings(x, any_missing, all_missing));
    return ScalarLogical(TRUE);
}

SEXP c_check_array(SEXP x, SEXP mode, SEXP any_missing, SEXP d, SEXP min_d, SEXP max_d) {
    if (!isArray(x))
        return make_type_error(x, "array");

    assert(check_storage(x, mode));

    if (!asFlag(any_missing, "any.missing") && any_missing_atomic(x))
        return make_result("Contains missing values");

    R_len_t ndim = length(getAttrib(x, R_DimSymbol));
    if (!isNull(d)) {
        R_len_t di = asCount(d, "d");
        if (ndim != di)
            return make_result("Must be a %i-d array, but has dimension %i", di, ndim);
    }

    if (!isNull(min_d)) {
        R_len_t di = asCount(min_d, "min.d");
        if (ndim < di)
            return make_result("Must have >=%i dimensions, but has dimension %i", di, ndim);
    }

    if (!isNull(max_d)) {
        R_len_t di = asCount(max_d, "max.d");
        if (ndim > di)
            return make_result("Must have <=%i dimensions, but has dimension %i", di, ndim);
    }

    return ScalarLogical(TRUE);
}

SEXP c_check_named(SEXP x, SEXP type) {
    if (!isNull(type) && xlength(x) > 0)
        assert(check_names(getAttrib(x, R_NamesSymbol), type, "Object"));
    return ScalarLogical(TRUE);
}

SEXP c_check_names(SEXP x, SEXP type) {
    if (!isString(x))
        return make_result("Must be a character vector of names");
    assert(check_names(x, type, "Object"));
    return ScalarLogical(TRUE);
}


SEXP c_check_numeric(SEXP x, SEXP lower, SEXP upper, SEXP finite, SEXP any_missing, SEXP all_missing, SEXP len, SEXP min_len, SEXP max_len, SEXP unique, SEXP names) {
    if (!isNumeric(x) && !all_missing_atomic(x))
        return make_type_error(x, "numeric");
    assert(check_vector_len(x, len, min_len, max_len));
    assert(check_vector_names(x, names));
    assert(check_vector_missings(x, any_missing, all_missing));
    assert(check_bounds(x, lower, upper));
    assert(check_vector_finite(x, finite));
    assert(check_vector_unique(x, unique));
    return ScalarLogical(TRUE);
}

SEXP c_check_vector(SEXP x, SEXP strict, SEXP any_missing, SEXP all_missing, SEXP len, SEXP min_len, SEXP max_len, SEXP unique, SEXP names) {
    if (!isVector(x))
        return make_type_error(x, "vector");
    if (asFlag(strict, "strict")) {
        SEXP attr = ATTRIB(x);
        if ((length(attr) > 0 && (TAG(attr) != R_NamesSymbol)) || CDR(attr) != R_NilValue)
            return make_type_error(x, "vector");
    }
    assert(check_vector_len(x, len, min_len, max_len));
    assert(check_vector_names(x, names));
    assert(check_vector_missings(x, any_missing, all_missing));
    assert(check_vector_unique(x, unique));
    return ScalarLogical(TRUE);
}

SEXP c_check_atomic(SEXP x, SEXP any_missing, SEXP all_missing, SEXP len, SEXP min_len, SEXP max_len, SEXP unique, SEXP names) {
    if (!isNull(x) && !isVectorAtomic(x))
        return make_type_error(x, "atomic");
    assert(check_vector_len(x, len, min_len, max_len));
    assert(check_vector_names(x, names));
    assert(check_vector_missings(x, any_missing, all_missing));
    assert(check_vector_unique(x, unique));
    return ScalarLogical(TRUE);
}

SEXP c_check_atomic_vector(SEXP x, SEXP any_missing, SEXP all_missing, SEXP len, SEXP min_len, SEXP max_len, SEXP unique, SEXP names) {
    if (!isVectorAtomic(x))
        return make_type_error(x, "atomic vector");
    assert(check_vector_len(x, len, min_len, max_len));
    assert(check_vector_names(x, names));
    assert(check_vector_missings(x, any_missing, all_missing));
    assert(check_vector_unique(x, unique));
    return ScalarLogical(TRUE);
}

/*********************************************************************************************************************/
/* Check functions for scalars                                                                                       */
/*********************************************************************************************************************/
static inline Rboolean is_scalar_na(SEXP x) {
    if (xlength(x) == 1) {
        switch(TYPEOF(x)) {
            case LGLSXP: return (LOGICAL(x)[0] == NA_LOGICAL);
            case INTSXP: return (INTEGER(x)[0] == NA_INTEGER);
            case REALSXP: return ISNAN(REAL(x)[0]);
            case STRSXP: return (STRING_ELT(x, 0) == NA_STRING);
        }
    }
    return FALSE;
}

SEXP c_check_flag(SEXP x, SEXP na_ok) {
    Rboolean is_na = is_scalar_na(x);
    if (xlength(x) != 1 || (!is_na && !isLogical(x)))
        return make_type_error(x, "logical flag");
    if (is_na && !asFlag(na_ok, "na.ok"))
        return make_result("May not be NA");
    return ScalarLogical(TRUE);
}

SEXP c_check_count(SEXP x, SEXP na_ok, SEXP positive, SEXP tol) {
    Rboolean is_na = is_scalar_na(x);
    double dtol = asNumber(tol, "tol");
    if (xlength(x) != 1 || (!is_na && !isIntegerish(x, dtol)))
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
    double dtol = asNumber(tol, "tol");
    if (xlength(x) != 1 || (!is_na && !isIntegerish(x, dtol)))
        return make_type_error(x, "single integerish value");
    if (is_na) {
        if (!asFlag(na_ok, "na.ok"))
            return make_result("May not be NA");
    }
    assert(check_bounds(x, lower, upper));
    return ScalarLogical(TRUE);
}

SEXP c_check_number(SEXP x, SEXP na_ok, SEXP lower, SEXP upper, SEXP finite) {
    Rboolean is_na = is_scalar_na(x);
    if (xlength(x) != 1 || (!is_na && !isStrictlyNumeric(x)))
        return make_type_error(x, "number");
    if (is_na) {
        if (!asFlag(na_ok, "na.ok"))
            return make_result("May not be NA");
        return ScalarLogical(TRUE);
    }
    assert(check_vector_finite(x, finite));
    assert(check_bounds(x, lower, upper));
    return ScalarLogical(TRUE);
}

SEXP c_check_string(SEXP x, SEXP na_ok) {
    Rboolean is_na = is_scalar_na(x);
    if (xlength(x) != 1 || (!is_na && !isString(x)))
        return make_type_error(x, "string");
    if (is_na && !asFlag(na_ok, "na.ok"))
        return make_result("May not be NA");
    return ScalarLogical(TRUE);
}

SEXP c_check_scalar(SEXP x, SEXP na_ok) {
    Rboolean is_na = is_scalar_na(x);
    if (xlength(x) != 1 || (!is_na && !isVectorAtomic(x)))
        return make_type_error(x, "atomic scalar");
    if (is_na && !asFlag(na_ok, "na.ok"))
        return make_result("May not be NA");
    return ScalarLogical(TRUE);
}
