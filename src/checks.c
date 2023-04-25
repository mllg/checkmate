#include <ctype.h>
#include <string.h>
#include <inttypes.h>
#include "backports.h"
#include "checks.h"
#include "integerish.h"
#include "is_sorted.h"
#include "any_missing.h"
#include "any_infinite.h"
#include "all_missing.h"
#include "find_nchar.h"
#include "helper.h"
#include "guess_type.h"

static char msg[255] = "";

#define HANDLE_TYPE(expr, expected) \
    if (!(expr)) { \
        snprintf(msg, 255, "Must be of type '%s', not '%s'", expected, guess_type(x)); \
        return ScalarString(mkChar(msg)); \
    }

#define HANDLE_TYPE_NULL(expr, expected, null_ok) \
    if (isNull((x))) { \
        if (as_flag((null_ok), "null.ok")) \
            return ScalarLogical(TRUE); \
        snprintf(msg, 255, "Must be of type '%s', not 'NULL'", expected); \
        return ScalarString(mkChar(msg)); \
    } else { \
        if (!(expr)) { \
            snprintf(msg, 255, "Must be of type '%s'%s, not '%s'", expected, as_flag(null_ok, "null_ok") ? " (or 'NULL')" : "", guess_type(x)); \
            return ScalarString(mkChar(msg)); \
        } \
    }

#define HANDLE_NA(x, na_ok) \
    if (is_scalar_na((x))) { \
        if (as_flag((na_ok), "na.ok")) \
            return ScalarLogical(TRUE); \
        return result("May not be NA"); \
    };

#define ASSERT_TRUE(x) if (!(x)) return ScalarString(mkChar(msg));
#define ASSERT_TRUE_UNPROTECT(x, p) \
    Rboolean TMP = (x); \
    UNPROTECT((p)); \
    if (!TMP) return ScalarString(mkChar(msg));

/*********************************************************************************************************************/
/* Some helpers                                                                                                      */
/*********************************************************************************************************************/
static Rboolean message(const char *fmt, ...) {
    va_list vargs;
    va_start(vargs, fmt);
    vsnprintf(msg, 255, fmt, vargs);
    va_end(vargs);
    return FALSE;
}

static SEXP result(const char *fmt, ...) {
    va_list vargs;
    va_start(vargs, fmt);
    vsnprintf(msg, 255, fmt, vargs);
    va_end(vargs);
    return ScalarString(mkChar(msg));
}

static void fmt_posixct(char * out, SEXP x) {
    SEXP call = PROTECT(allocVector(LANGSXP, 2));
    SETCAR(call, install("format.POSIXct"));
    SETCADR(call, x);
    SEXP result = PROTECT(eval(call, R_GlobalEnv));

    strncpy(out, CHAR(STRING_ELT(result, 0)), 255);
    out[255] = '\0';
    UNPROTECT(2);
}

static Rboolean check_bounds(SEXP x, SEXP lower, SEXP upper) {
    double tmp = as_number(lower, "lower");
    if (R_FINITE(tmp) || tmp == R_PosInf) {
        const R_xlen_t n = xlength(x);
        if (isReal(x)) {
            const double *xp = REAL_RO(x);
            for (R_xlen_t i = 0; i < n; i++) {
                if (!ISNAN(xp[i]) && xp[i] < tmp)
                    return message("Element %i is not >= %g", i + 1, tmp);
            }
        } else if (isInteger(x)) {
            const int *xp = INTEGER_RO(x);
            for (R_xlen_t i = 0; i < n; i++) {
                if (xp[i] != NA_INTEGER && xp[i] < tmp)
                    return message("Element %i is not >= %g", i + 1, tmp);
            }
        }
    }

    tmp = as_number(upper, "upper");
    if (R_FINITE(tmp) || tmp == R_NegInf) {
        const R_xlen_t n = xlength(x);
        if (isReal(x)) {
            const double *xp = REAL_RO(x);
            for (R_xlen_t i = 0; i < n; i++) {
                if (!ISNAN(xp[i]) && xp[i] > tmp)
                    return message("Element %i is not <= %g", i + 1, tmp);
            }
        } else if (isInteger(x)) {
            const int *xp = INTEGER_RO(x);
            for (R_xlen_t i = 0; i < n; i++) {
                if (xp[i] != NA_INTEGER && xp[i] > tmp)
                    return message("Element %i is not <= %g", i + 1, tmp);
            }
        }
    }
    return TRUE;
}


static Rboolean check_posix_bounds(SEXP x, SEXP lower, SEXP upper) {
    if (isNull(lower) && isNull(upper))
        return TRUE;

    SEXP tz = PROTECT(getAttrib(x, install("tzone")));
    R_len_t NPROTECT = 1;
    const Rboolean null_tz = isNull(tz);
    double *xp;
    if (isInteger(x)) {
        SEXP xr = PROTECT(coerceVector(x, REALSXP));
        NPROTECT++;
        xp = REAL(xr);
    } else {
        xp = REAL(x);
    }


    if (!isNull(lower)) {
        if (!is_class_posixct(lower) || length(lower) != 1)
            error("Argument 'lower' must be provided as single POSIXct time");
        SEXP lower_tz = PROTECT(getAttrib(lower, install("tzone")));
        NPROTECT++;
        if (null_tz != isNull(lower_tz) ||
            (!null_tz && !isNull(lower_tz) && strcmp(CHAR(STRING_ELT(tz, 0)), CHAR(STRING_ELT(lower_tz, 0))) != 0)) {
            UNPROTECT(NPROTECT);
            return message("Timezones of 'x' and 'lower' must match");
        }

        const double tmp = isInteger(lower) ? (double) INTEGER_RO(lower)[0] : REAL_RO(lower)[0];
        const R_xlen_t n = length(x);
        for (R_xlen_t i = 0; i < n; i++) {
            if (!ISNAN(xp[i]) && xp[i] < tmp) {
                char fmt[256];
                fmt_posixct(fmt, lower);
                UNPROTECT(NPROTECT);
                return message("Element %i is not >= %s", i + 1, fmt);
            }
        }
    }

    if (!isNull(upper)) {
        if (!is_class_posixct(upper) || length(upper) != 1)
            error("Argument 'upper' must be provided as single POSIXct time");
        SEXP upper_tz = PROTECT(getAttrib(upper, install("tzone")));
        NPROTECT++;
        if (null_tz != isNull(upper_tz) ||
            (!null_tz && !isNull(upper_tz) && strcmp(CHAR(STRING_ELT(tz, 0)), CHAR(STRING_ELT(upper_tz, 0))) != 0)) {
            UNPROTECT(NPROTECT);
            return message("Timezones of 'x' and 'upper' must match");
        }

        const double tmp = isInteger(upper) ? (double) INTEGER_RO(upper)[0] : REAL_RO(upper)[0];
        const R_xlen_t n = length(x);
        for (R_xlen_t i = 0; i < n; i++) {
            if (!ISNAN(xp[i]) && xp[i] > tmp) {
                char fmt[256];
                fmt_posixct(fmt, upper);
                UNPROTECT(NPROTECT);
                return message("Element %i is not <= %s", i + 1, fmt);
            }
        }
    }

    UNPROTECT(NPROTECT);
    return TRUE;
}

static R_xlen_t check_strict_names(SEXP x) {
    const R_xlen_t nx = xlength(x);
    const char *str;
    for (R_xlen_t i = 0; i < nx; i++) {
        str = CHAR(STRING_ELT(x, i));
        while (*str == '.')
            str++;
        if (!isalpha(*str))
            return i + 1;
        for (; *str != '\0'; str++) {
            if (!isalnum(*str) && *str != '.' && *str != '_')
                return i + 1;
        }
    }
    return 0;
}

static Rboolean check_names(SEXP nn, const char * type, const char * what) {
    typedef enum { T_UNNAMED, T_NAMED, T_UNIQUE, T_STRICT, T_IDS } name_t;
    name_t checks = T_UNNAMED;

    if (strcmp(type, "unnamed") == 0)
        return isNull(nn) ? TRUE : message("May not have %s", what);

    if (strcmp(type, "named") == 0) {
        checks = T_NAMED;
    } else if (strcmp(type, "unique") == 0) {
        checks = T_UNIQUE;
    } else if (strcmp(type, "strict") == 0) {
        checks = T_STRICT;
    } else if (strcmp(type, "ids") == 0) {
        checks = T_IDS;
    } else {
        error("Unknown type '%s' to specify check for names. Supported are 'unnamed', 'named', 'unique' and 'strict'.", type);
    }

    if (isNull(nn)) {
        return message("Must have %s", what);
    }

    R_xlen_t pos = find_missing_string(nn);
    if (pos > 0) {
        return message("Must have %s, but is NA at position %i", what, pos);
    }

    pos = find_min_nchar(nn, 1);
    if (pos > 0) {
        return message("Must have %s, but element %i is empty", what, pos);
    }

    if (checks == T_UNIQUE || checks == T_STRICT) {
        pos = any_duplicated(nn, FALSE);
        if (pos > 0)
            return message("Must have unique %s, but element %i is duplicated", what, pos);
    }

    if (checks == T_STRICT || checks == T_IDS) {
        pos = check_strict_names(nn);
        if (pos > 0)
            return message("Must have %s according to R's variable naming conventions, but element %i does not comply", what, pos);
    }
    return TRUE;
}

static Rboolean check_named(SEXP x, const char * type, const char * what) {
    SEXP nn = PROTECT(getAttrib(x, R_NamesSymbol));
    Rboolean res = check_names(nn, type, what);
    UNPROTECT(1);
    return res;
}

static Rboolean check_vector_len(SEXP x, SEXP len, SEXP min_len, SEXP max_len) {
    if (!isNull(len)) {
        R_xlen_t n = as_length(len, "len");
        if (xlength(x) != n)
            return message("Must have length %g, but has length %g", (double)n, (double)xlength(x));
    }
    if (!isNull(min_len)) {
        R_xlen_t n = as_length(min_len, "min.len");
        if (xlength(x) < n)
            return message("Must have length >= %g, but has length %g", (double)n, (double)xlength(x));
    }
    if (!isNull(max_len)) {
        R_xlen_t n = as_length(max_len, "max.len");
        if (xlength(x) > n)
            return message("Must have length <= %g, but has length %g", (double)n, (double)xlength(x));
    }
    return TRUE;
}

static Rboolean check_vector_missings(SEXP x, SEXP any_missing, SEXP all_missing) {
    if (!as_flag(any_missing, "any.missing")) {
        R_xlen_t pos = find_missing_vector(x);
        if (pos > 0)
            return message("Contains missing values (element %i)", pos);
    }
    if (!as_flag(all_missing, "all.missing") && all_missing_atomic(x))
        return message("Contains only missing values");
    return TRUE;
}

static Rboolean check_vector_unique(SEXP x, SEXP unique) {
    if (as_flag(unique, "unique")) {
        R_xlen_t pos = any_duplicated(x, FALSE);
        if (pos > 0)
            return message("Contains duplicated values, position %i", pos);
    }
    return TRUE;
}

static Rboolean check_vector_names(SEXP x, SEXP names) {
    if (!isNull(names) && xlength(x) > 0)
        return check_named(x, as_string(names, "names"), "names");
    return TRUE;
}

static Rboolean check_vector_finite(SEXP x, SEXP finite) {
    // FIXME: pos
    if (as_flag(finite, "finite") && any_infinite(x))
        return message("Must be finite");
    return TRUE;
}

static Rboolean check_matrix_dims(SEXP x, SEXP min_rows, SEXP max_rows, SEXP min_cols, SEXP max_cols, SEXP rows, SEXP cols) {
    if (!isNull(min_rows) || !isNull(max_rows) || !isNull(rows)) {
        R_len_t xrows = get_nrows(x);
        if (!isNull(min_rows)) {
            R_len_t cmp = as_length(min_rows, "min.rows");
            if (xrows < cmp)
                return message("Must have at least %i rows, but has %i rows", cmp, xrows);
        }
        if (!isNull(max_rows)) {
            R_len_t cmp = as_length(max_rows, "max.rows");
            if (xrows > cmp)
                return message("Must have at most %i rows, but has %i rows", cmp, xrows);
        }
        if (!isNull(rows)) {
            R_len_t cmp = as_length(rows, "rows");
            if (xrows != cmp)
                return message("Must have exactly %i rows, but has %i rows", cmp, xrows);
        }
    }
    if (!isNull(min_cols) || !isNull(max_cols) || !isNull(cols)) {
        R_len_t xcols = get_ncols(x);
        if (!isNull(min_cols)) {
            R_len_t cmp = as_length(min_cols, "min.cols");
            if (xcols < cmp)
                return message("Must have at least %i cols, but has %i cols", cmp, xcols);
        }
        if (!isNull(max_cols)) {
            R_len_t cmp = as_length(max_cols, "max.cols");
            if (xcols > cmp)
                return message("Must have at most %i cols, but has %i cols", cmp, xcols);
        }
        if (!isNull(cols)) {
            R_len_t cmp = as_count(cols, "cols");
            if (xcols != cmp)
                return message("Must have exactly %i cols, but has %i cols", cmp, xcols);
        }
    }
    return TRUE;
}

static Rboolean check_storage(SEXP x, SEXP mode) {
    if (!isNull(mode) && !all_missing(x)) {

        const char * const storage = as_string(mode, "mode");
        if (strcmp(storage, "logical") == 0) {
            if (!isLogical(x))
                return message("Must store logicals");
        } else if (strcmp(storage, "integer") == 0) {
            if (!isInteger(x))
                return message("Must store integers");
        } else if (strcmp(storage, "double") == 0) {
            if (!isReal(x))
                return message("Must store doubles");
        } else if (strcmp(storage, "integerish") == 0) {
            if (!isIntegerish(x, INTEGERISH_DEFAULT_TOL, FALSE))
                return message("Must store integerish values");
        } else if (strcmp(storage, "numeric") == 0) {
            if (!is_class_numeric(x))
                return message("Must store numerics");
        } else if (strcmp(storage, "complex") == 0) {
            if (!isComplex(x))
                return message("Must store complexs");
        } else if (strcmp(storage, "character") == 0) {
            if (!isString(x))
                return message("Must store characters");
        } else if (strcmp(storage, "list") == 0) {
            if (!is_class_list(x))
                return message("Must store a list");
        } else if (strcmp(storage, "atomic") == 0) {
            if (!isVectorAtomic(x))
                return message("Must be atomic");
        } else {
            error("Invalid argument 'mode'. Must be one of 'logical', 'integer', 'integerish', 'double', 'numeric', 'complex', 'character', 'list' or 'atomic'");
        }
    }
    return TRUE;
}

static inline Rboolean is_scalar_na(SEXP x) {
    if (xlength(x) == 1) {
        switch(TYPEOF(x)) {
            case LGLSXP: return (LOGICAL_RO(x)[0] == NA_LOGICAL);
            case INTSXP: return (INTEGER_RO(x)[0] == NA_INTEGER);
            case REALSXP: return ISNAN(REAL_RO(x)[0]);
            case STRSXP: return (STRING_ELT(x, 0) == NA_STRING);
        }
    }
    return FALSE;
}

static Rboolean check_vector_sorted(SEXP x, SEXP sorted) {
    if (as_flag(sorted, "sorted") && xlength(x) > 1) {
        if (!is_sorted(x)) {
            return message("Must be sorted");
        }
    }
    return TRUE;
}

static Rboolean check_typed_missing(SEXP x, SEXP typed_missing) {
    if (as_flag(typed_missing, "typed.missing")) {
        return FALSE;
    }

    return TYPEOF(x) != VECSXP && all_missing_atomic(x);
}

static Rboolean check_string_nchar(SEXP x, SEXP n_chars, SEXP min_chars, SEXP max_chars) {
    if (!isNull(n_chars)) {
        R_xlen_t n = as_count(n_chars, "n.chars");
        R_xlen_t pos = find_nchar(x, n);
        if (pos > 0) {
            return message("All elements must have exactly %i characters, but element %i has %i chararacters",
            n, pos, get_nchars(x, pos - 1));
        }
    }

    if (!isNull(min_chars)) {
        R_xlen_t n = as_count(min_chars, "min.chars");
        R_xlen_t pos = find_min_nchar(x, n);
        if (pos > 0) {
            return message("All elements must have at least %i characters, but element %i has %i characters",
            n, pos, get_nchars(x, pos - 1));
        }
    }

    if (!isNull(max_chars)) {
        R_xlen_t n = as_count(max_chars, "max.chars");
        R_xlen_t pos = find_max_nchar(x, n);
        if (pos > 0) {
            return message("All elements must have at most %i characters, but element %i has %i characters",
            n, pos, get_nchars(x, pos - 1));
        }
    }

    return TRUE;
}

/*********************************************************************************************************************/
/* Exported check functions                                                                                          */
/*********************************************************************************************************************/
SEXP attribute_hidden c_check_logical(SEXP x, SEXP any_missing, SEXP all_missing, SEXP len, SEXP min_len, SEXP max_len, SEXP unique, SEXP names, SEXP typed_missing, SEXP null_ok) {
    HANDLE_TYPE_NULL(is_class_logical(x) || check_typed_missing(x, typed_missing), "logical", null_ok);
    ASSERT_TRUE(check_vector_len(x, len, min_len, max_len));
    ASSERT_TRUE(check_vector_names(x, names));
    ASSERT_TRUE(check_vector_missings(x, any_missing, all_missing));
    ASSERT_TRUE(check_vector_unique(x, unique));
    return ScalarLogical(TRUE);
}

SEXP attribute_hidden c_check_integer(SEXP x, SEXP lower, SEXP upper, SEXP any_missing, SEXP all_missing, SEXP len, SEXP min_len, SEXP max_len, SEXP unique, SEXP sorted, SEXP names, SEXP typed_missing, SEXP null_ok) {
    HANDLE_TYPE_NULL(is_class_integer(x) || check_typed_missing(x, typed_missing), "integer", null_ok);
    ASSERT_TRUE(check_vector_len(x, len, min_len, max_len));
    ASSERT_TRUE(check_vector_names(x, names));
    ASSERT_TRUE(check_vector_missings(x, any_missing, all_missing));
    ASSERT_TRUE(check_bounds(x, lower, upper));
    ASSERT_TRUE(check_vector_unique(x, unique));
    ASSERT_TRUE(check_vector_sorted(x, sorted));
    return ScalarLogical(TRUE);
}

SEXP attribute_hidden c_check_integerish(SEXP x, SEXP tol, SEXP lower, SEXP upper, SEXP any_missing, SEXP all_missing, SEXP len, SEXP min_len, SEXP max_len, SEXP unique, SEXP sorted, SEXP names, SEXP typed_missing, SEXP null_ok) {
    double dtol = as_number(tol, "tol");
    if (isNull((x))) {
        if (as_flag((null_ok), "null.ok"))
            return ScalarLogical(TRUE);
        snprintf(msg, 255, "Must be of type 'integerish', not 'NULL'");
        return ScalarString(mkChar(msg));
    } else {
        cm_int_err_t ok = checkIntegerish(x, dtol, FALSE);
        switch(ok.err) {
            case INT_OK:
                break;
            case INT_TYPE:
                if (!check_typed_missing(x, typed_missing)) {
                    snprintf(msg, 255, "Must be of type 'integerish'%s, not '%s'", as_flag(null_ok, "null_ok") ? " (or 'NULL')" : "", guess_type(x));
                    return ScalarString(mkChar(msg));
                }
                break;
            case INT_RANGE:
                snprintf(msg, 255, "Must be of type 'integerish', but element %jd is not in integer range", ok.pos);
                return ScalarString(mkChar(msg));
                break;
            case INT_TOL:
                snprintf(msg, 255, "Must be of type 'integerish', but element %jd is not close to an integer", ok.pos);
                return ScalarString(mkChar(msg));
                break;
            case INT_COMPLEX:
                snprintf(msg, 255, "Must be of type 'integerish', but element %jd has an imaginary part", ok.pos);
                return ScalarString(mkChar(msg));
                break;
        }
    }

    ASSERT_TRUE(check_vector_len(x, len, min_len, max_len));
    ASSERT_TRUE(check_vector_names(x, names));
    ASSERT_TRUE(check_vector_missings(x, any_missing, all_missing));
    ASSERT_TRUE(check_bounds(x, lower, upper));
    ASSERT_TRUE(check_vector_unique(x, unique));
    ASSERT_TRUE(check_vector_sorted(x, sorted));
    return ScalarLogical(TRUE);
}

SEXP attribute_hidden c_check_double(SEXP x, SEXP lower, SEXP upper, SEXP finite, SEXP any_missing, SEXP all_missing, SEXP len, SEXP min_len, SEXP max_len, SEXP unique, SEXP sorted, SEXP names, SEXP typed_missing, SEXP null_ok) {
    HANDLE_TYPE_NULL(is_class_double(x) || check_typed_missing(x, typed_missing), "double", null_ok);
    ASSERT_TRUE(check_vector_len(x, len, min_len, max_len));
    ASSERT_TRUE(check_vector_names(x, names));
    ASSERT_TRUE(check_vector_missings(x, any_missing, all_missing));
    ASSERT_TRUE(check_bounds(x, lower, upper));
    ASSERT_TRUE(check_vector_finite(x, finite));
    ASSERT_TRUE(check_vector_unique(x, unique));
    ASSERT_TRUE(check_vector_sorted(x, sorted));
    return ScalarLogical(TRUE);
}

SEXP attribute_hidden c_check_numeric(SEXP x, SEXP lower, SEXP upper, SEXP finite, SEXP any_missing, SEXP all_missing, SEXP len, SEXP min_len, SEXP max_len, SEXP unique, SEXP sorted, SEXP names, SEXP typed_missing, SEXP null_ok) {
    HANDLE_TYPE_NULL(is_class_numeric(x) || check_typed_missing(x, typed_missing), "numeric", null_ok);
    ASSERT_TRUE(check_vector_len(x, len, min_len, max_len));
    ASSERT_TRUE(check_vector_names(x, names));
    ASSERT_TRUE(check_vector_missings(x, any_missing, all_missing));
    ASSERT_TRUE(check_bounds(x, lower, upper));
    ASSERT_TRUE(check_vector_finite(x, finite));
    ASSERT_TRUE(check_vector_unique(x, unique));
    ASSERT_TRUE(check_vector_sorted(x, sorted));
    return ScalarLogical(TRUE);
}


SEXP attribute_hidden c_check_character(SEXP x, SEXP n_chars, SEXP min_chars, SEXP max_chars, SEXP any_missing, SEXP all_missing, SEXP len, SEXP min_len, SEXP max_len, SEXP unique, SEXP sorted, SEXP names, SEXP typed_missing, SEXP null_ok) {
    HANDLE_TYPE_NULL(is_class_string(x) || check_typed_missing(x, typed_missing), "character", null_ok);
    ASSERT_TRUE(check_vector_len(x, len, min_len, max_len));
    ASSERT_TRUE(check_vector_names(x, names));
    ASSERT_TRUE(check_vector_missings(x, any_missing, all_missing));
    ASSERT_TRUE(check_string_nchar(x, n_chars, min_chars, max_chars));
    ASSERT_TRUE(check_vector_unique(x, unique));
    ASSERT_TRUE(check_vector_sorted(x, sorted));
    return ScalarLogical(TRUE);
}

SEXP attribute_hidden c_check_complex(SEXP x, SEXP any_missing, SEXP all_missing, SEXP len, SEXP min_len, SEXP max_len, SEXP unique, SEXP names, SEXP typed_missing, SEXP null_ok) {
    HANDLE_TYPE_NULL(is_class_complex(x) || check_typed_missing(x, typed_missing), "complex", null_ok);
    ASSERT_TRUE(check_vector_len(x, len, min_len, max_len));
    ASSERT_TRUE(check_vector_names(x, names));
    ASSERT_TRUE(check_vector_missings(x, any_missing, all_missing));
    ASSERT_TRUE(check_vector_unique(x, unique));
    return ScalarLogical(TRUE);
}

SEXP attribute_hidden c_check_dataframe(SEXP x, SEXP any_missing, SEXP all_missing, SEXP min_rows, SEXP max_rows, SEXP min_cols, SEXP max_cols, SEXP rows, SEXP cols, SEXP row_names, SEXP col_names, SEXP null_ok) {
    HANDLE_TYPE_NULL(is_class_frame(x), "data.frame", null_ok);
    ASSERT_TRUE(check_matrix_dims(x, min_rows, max_rows, min_cols, max_cols, rows, cols));

    if (!isNull(row_names)) {
        SEXP nn = PROTECT(getAttrib(x, install("row.names")));
        int nprotect = 1;
        if (isInteger(nn)) {
            nn = PROTECT(coerceVector(nn, STRSXP));
            nprotect++;
        }
        ASSERT_TRUE_UNPROTECT(check_names(nn, as_string(row_names, "row.names"), "rownames"), nprotect);
    }

    if (!isNull(col_names)) {
        ASSERT_TRUE(check_named(x, as_string(col_names, "col.names"), "colnames"));
    }
    if (!as_flag(any_missing, "any.missing")) {
        R_xlen_t pos = find_missing_frame(x);
        if (pos > 0) {
            R_xlen_t nrow = get_nrows(x);
            const char * nn = CHAR(STRING_ELT(getAttrib(x, R_NamesSymbol), translate_col(pos, nrow)));
            return result("Contains missing values (column '%s', row %i)",
                    nn, translate_row(pos, nrow) + 1);
        }
    }

    if (!as_flag(all_missing, "all.missing") && all_missing_frame(x)) {
        return result("Contains only missing values");
    }
    return ScalarLogical(TRUE);
}

SEXP attribute_hidden c_check_factor(SEXP x, SEXP any_missing, SEXP all_missing, SEXP len, SEXP min_len, SEXP max_len, SEXP unique, SEXP names, SEXP null_ok) {
    HANDLE_TYPE_NULL(is_class_factor(x), "factor", null_ok);
    ASSERT_TRUE(check_vector_len(x, len, min_len, max_len));
    ASSERT_TRUE(check_vector_names(x, names));
    ASSERT_TRUE(check_vector_missings(x, any_missing, all_missing));
    ASSERT_TRUE(check_vector_unique(x, unique));
    return ScalarLogical(TRUE);
}


SEXP attribute_hidden c_check_list(SEXP x, SEXP any_missing, SEXP all_missing, SEXP len, SEXP min_len, SEXP max_len, SEXP unique, SEXP names, SEXP null_ok) {
    HANDLE_TYPE_NULL(is_class_list(x), "list", null_ok)
    ASSERT_TRUE(check_vector_len(x, len, min_len, max_len));
    ASSERT_TRUE(check_vector_names(x, names));
    ASSERT_TRUE(check_vector_missings(x, any_missing, all_missing));
    ASSERT_TRUE(check_vector_unique(x, unique));
    return ScalarLogical(TRUE);
}

SEXP attribute_hidden c_check_matrix(SEXP x, SEXP mode, SEXP any_missing, SEXP all_missing, SEXP min_rows, SEXP max_rows, SEXP min_cols, SEXP max_cols, SEXP rows, SEXP cols, SEXP row_names, SEXP col_names, SEXP null_ok) {
    HANDLE_TYPE_NULL(is_class_matrix(x), "matrix", null_ok);
    ASSERT_TRUE(check_storage(x, mode));
    ASSERT_TRUE(check_matrix_dims(x, min_rows, max_rows, min_cols, max_cols, rows, cols));

    if (!isNull(row_names) && xlength(x) > 0) {
        SEXP nn = PROTECT(getAttrib(x, R_DimNamesSymbol));
        if (!isNull(nn))
            nn = VECTOR_ELT(nn, 0);
        ASSERT_TRUE_UNPROTECT(check_names(nn, as_string(row_names, "row.names"), "rownames"), 1);
    }

    if (!isNull(col_names) && xlength(x) > 0) {
        SEXP nn = PROTECT(getAttrib(x, R_DimNamesSymbol));
        if (!isNull(nn))
            nn = VECTOR_ELT(nn, 1);
        ASSERT_TRUE_UNPROTECT(check_names(nn, as_string(col_names, "col.names"), "colnames"), 1);
    }

    if (!as_flag(any_missing, "any.missing")) {
        R_xlen_t pos = find_missing_matrix(x);
        if (pos > 0) {
            R_xlen_t nrow = get_nrows(x);
            return result("Contains missing values (row %i, col %i)",
                    translate_row(pos, nrow) + 1, translate_col(pos, nrow) + 1);
        }
    }

    if (!as_flag(all_missing, "all.missing") && all_missing_atomic(x)) {
        return result("Contains only missing values");
    }
    return ScalarLogical(TRUE);
}

SEXP attribute_hidden c_check_array(SEXP x, SEXP mode, SEXP any_missing, SEXP d, SEXP min_d, SEXP max_d, SEXP null_ok) {
    HANDLE_TYPE_NULL(is_class_array(x), "array", null_ok);
    ASSERT_TRUE(check_storage(x, mode));

    if (!as_flag(any_missing, "any.missing") && find_missing_vector(x) > 0)
        return result("Contains missing values");

    R_len_t ndim = length(getAttrib(x, R_DimSymbol));
    if (!isNull(d)) {
        R_len_t di = as_count(d, "d");
        if (ndim != di)
            return result("Must be a %i-d array, but has dimension %i", di, ndim);
    }

    if (!isNull(min_d)) {
        R_len_t di = as_count(min_d, "min.d");
        if (ndim < di)
            return result("Must have >=%i dimensions, but has dimension %i", di, ndim);
    }

    if (!isNull(max_d)) {
        R_len_t di = as_count(max_d, "max.d");
        if (ndim > di)
            return result("Must have <=%i dimensions, but has dimension %i", di, ndim);
    }

    return ScalarLogical(TRUE);
}

SEXP attribute_hidden c_check_named(SEXP x, SEXP type) {
    if (!isNull(type) && xlength(x) > 0)
        ASSERT_TRUE(check_named(x, as_string(type, "type"), "Object"));
    return ScalarLogical(TRUE);
}

SEXP attribute_hidden c_check_names(SEXP x, SEXP type, SEXP what) {
    if (!(isString(x) || isNull(x)))
        return result("Must be a character vector");
    ASSERT_TRUE(check_names(x, as_string(type, "type"), as_string(what, "what")));
    return ScalarLogical(TRUE);
}


SEXP attribute_hidden c_check_vector(SEXP x, SEXP strict, SEXP any_missing, SEXP all_missing, SEXP len, SEXP min_len, SEXP max_len, SEXP unique, SEXP names, SEXP null_ok) {
    HANDLE_TYPE_NULL(isVector(x), "vector", null_ok);
    if (as_flag(strict, "strict")) {
        SEXP attr = ATTRIB(x);
        HANDLE_TYPE( (length(attr) == 0 || (TAG(attr) == R_NamesSymbol)) && CDR(attr) == R_NilValue, "vector");
    }
    ASSERT_TRUE(check_vector_len(x, len, min_len, max_len));
    ASSERT_TRUE(check_vector_names(x, names));
    ASSERT_TRUE(check_vector_missings(x, any_missing, all_missing));
    ASSERT_TRUE(check_vector_unique(x, unique));
    return ScalarLogical(TRUE);
}

SEXP attribute_hidden c_check_raw(SEXP x, SEXP len, SEXP min_len, SEXP max_len, SEXP names, SEXP null_ok) {
    HANDLE_TYPE_NULL(is_class_raw(x), "raw", null_ok);
    ASSERT_TRUE(check_vector_len(x, len, min_len, max_len));
    ASSERT_TRUE(check_vector_names(x, names));
    return ScalarLogical(TRUE);
}

SEXP attribute_hidden c_check_atomic(SEXP x, SEXP any_missing, SEXP all_missing, SEXP len, SEXP min_len, SEXP max_len, SEXP unique, SEXP names) {
    HANDLE_TYPE(is_class_atomic(x), "atomic");
    ASSERT_TRUE(check_vector_len(x, len, min_len, max_len));
    ASSERT_TRUE(check_vector_names(x, names));
    ASSERT_TRUE(check_vector_missings(x, any_missing, all_missing));
    ASSERT_TRUE(check_vector_unique(x, unique));
    return ScalarLogical(TRUE);
}

SEXP attribute_hidden c_check_atomic_vector(SEXP x, SEXP any_missing, SEXP all_missing, SEXP len, SEXP min_len, SEXP max_len, SEXP unique, SEXP names) {
    HANDLE_TYPE(is_class_atomic_vector(x), "atomic vector");
    ASSERT_TRUE(check_vector_len(x, len, min_len, max_len));
    ASSERT_TRUE(check_vector_names(x, names));
    ASSERT_TRUE(check_vector_missings(x, any_missing, all_missing));
    ASSERT_TRUE(check_vector_unique(x, unique));
    return ScalarLogical(TRUE);
}

SEXP attribute_hidden c_check_flag(SEXP x, SEXP na_ok, SEXP null_ok) {
    HANDLE_NA(x, na_ok);
    HANDLE_TYPE_NULL(isLogical(x), "logical flag", null_ok);
    if (xlength(x) != 1)
        return result("Must have length 1");
    return ScalarLogical(TRUE);
}

SEXP attribute_hidden c_check_count(SEXP x, SEXP na_ok, SEXP positive, SEXP tol, SEXP null_ok) {
    HANDLE_NA(x, na_ok)
    double dtol = as_number(tol, "tol");
    HANDLE_TYPE_NULL(isIntegerish(x, dtol, FALSE), "count", null_ok);
    if (xlength(x) != 1)
        return result("Must have length 1");
    const int pos = (int) as_flag(positive, "positive");
    if (asInteger(x) < pos)
        return result("Must be >= %i", pos);
    return ScalarLogical(TRUE);
}

SEXP attribute_hidden c_check_int(SEXP x, SEXP na_ok, SEXP lower, SEXP upper, SEXP tol, SEXP null_ok) {
    double dtol = as_number(tol, "tol");
    HANDLE_NA(x, na_ok);
    HANDLE_TYPE_NULL(isIntegerish(x, dtol, FALSE), "single integerish value", null_ok);
    if (xlength(x) != 1)
        return result("Must have length 1");
    ASSERT_TRUE(check_bounds(x, lower, upper));
    return ScalarLogical(TRUE);
}

SEXP attribute_hidden c_check_number(SEXP x, SEXP na_ok, SEXP lower, SEXP upper, SEXP finite, SEXP null_ok) {
    HANDLE_NA(x, na_ok);
    HANDLE_TYPE_NULL(is_class_numeric(x), "number", null_ok);
    if (xlength(x) != 1)
        return result("Must have length 1");
    ASSERT_TRUE(check_vector_finite(x, finite));
    ASSERT_TRUE(check_bounds(x, lower, upper));
    return ScalarLogical(TRUE);
}

SEXP attribute_hidden c_check_string(SEXP x, SEXP na_ok, SEXP n_chars, SEXP min_chars, SEXP max_chars, SEXP null_ok) {
    HANDLE_NA(x, na_ok);
    HANDLE_TYPE_NULL(isString(x), "string", null_ok);
    if (xlength(x) != 1)
        return result("Must have length 1");
    ASSERT_TRUE(check_string_nchar(x, n_chars, min_chars, max_chars));

    return ScalarLogical(TRUE);
}

SEXP attribute_hidden c_check_scalar(SEXP x, SEXP na_ok, SEXP null_ok) {
    HANDLE_NA(x, na_ok);
    HANDLE_TYPE_NULL(isVectorAtomic(x), "atomic scalar", null_ok);
    if (xlength(x) != 1)
        return result("Must have length 1");
    return ScalarLogical(TRUE);
}

SEXP attribute_hidden c_check_posixct(SEXP x, SEXP lower, SEXP upper, SEXP any_missing, SEXP all_missing, SEXP len, SEXP min_len, SEXP max_len, SEXP unique, SEXP sorted, SEXP null_ok) {
    HANDLE_TYPE_NULL(is_class_posixct(x), "POSIXct", null_ok);
    ASSERT_TRUE(check_vector_len(x, len, min_len, max_len));
    ASSERT_TRUE(check_vector_missings(x, any_missing, all_missing));
    ASSERT_TRUE(check_vector_unique(x, unique));
    ASSERT_TRUE(check_posix_bounds(x, lower, upper));
    ASSERT_TRUE(check_vector_sorted(x, sorted));

    return ScalarLogical(TRUE);
}

#undef HANDLE_TYPE
#undef HANDLE_TYPE_NULL
#undef HANDLE_NA
#undef ASSERT_TRUE
#undef ASSERT_TRUE_UNPROTECT
