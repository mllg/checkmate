#include "check_scalar.h"
#include "is_integerish.h"
#include "any_missing.h"
#include "all_missing.h"

static inline Rboolean is_na_ok(SEXP x) {
    if (!isLogical(x) ||length(x) != 1)
        error("na.ok must be a flag");
    return LOGICAL(x)[0];
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

SEXP c_check_flag(SEXP x, SEXP na_ok) {
    Rboolean is_na = is_scalar_na(x);
    if (length(x) != 1 || (!isLogical(x) && !is_na))
        return ScalarString(mkChar("Must be a logical flag"));
    if (is_na && !is_na_ok(na_ok))
        return ScalarString(mkChar("May not be NA"));
    return ScalarLogical(TRUE);
}

SEXP c_check_count(SEXP x, SEXP na_ok) {
    Rboolean is_na = is_scalar_na(x);
    if (length(x) != 1 || (!isIntegerish(x, DEFAULT_TOL) && !is_na))
        return ScalarString(mkChar("Must be a count"));
    if (is_na) {
        if (!is_na_ok(na_ok))
            return ScalarString(mkChar("May not be NA"));
    } else if (asInteger(x) < 0) {
        return ScalarString(mkChar("Must be >= 0"));
    }
    return ScalarLogical(TRUE);
}

SEXP c_check_number(SEXP x, SEXP na_ok) {
    Rboolean is_na = is_scalar_na(x);
    if (length(x) != 1 || (!isInteger(x) && !isReal(x) && !is_na))
        return ScalarString(mkChar("Must be a number"));
    if (is_na && !is_na_ok(na_ok))
        return ScalarString(mkChar("May not be NA"));
    return ScalarLogical(TRUE);
}

SEXP c_check_string(SEXP x, SEXP na_ok) {
    Rboolean is_na = is_scalar_na(x);
    if (length(x) != 1 || (!isString(x) && !is_na))
        return ScalarString(mkChar("Must be a string"));
    if (is_na && !is_na_ok(na_ok))
        return ScalarString(mkChar("May not be NA"));
    return ScalarLogical(TRUE);
}
