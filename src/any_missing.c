#include "any_missing.h"

miss_t any_missing_logical(SEXP x) {
    const int * xp = LOGICAL(x);
    const int * const xe = xp + xlength(x);
    for (; xp != xe; xp++) {
        if (*xp == NA_LOGICAL)
            return MISS_LOGICAL;
    }
    return MISS_NONE;
}

miss_t any_missing_integer(SEXP x) {
    const int * xp = INTEGER(x);
    const int * const xe = xp + xlength(x);
    for (; xp != xe; xp++) {
        if (*xp == NA_INTEGER)
            return MISS_INTEGER;
    }
    return MISS_NONE;
}

miss_t any_missing_integerish(SEXP x) {
    switch(TYPEOF(x)) {
        case LGLSXP: return any_missing_logical(x);
        case INTSXP: return any_missing_integer(x);
        case REALSXP: return any_missing_double(x);
        default: error("Error in any_missing_logical: x is not logical or numeric");
    }
}

miss_t any_missing_double(SEXP x) {
    const double * xp = REAL(x);
    const double * const xe = xp + xlength(x);
    for (; xp != xe; xp++) {
        if (ISNAN(*xp))
            return MISS_DOUBLE;
    }
    return MISS_NONE;
}

miss_t any_missing_numeric(SEXP x) {
    switch(TYPEOF(x)) {
        case INTSXP: return any_missing_integer(x);
        case REALSXP: return any_missing_double(x);
        default: error("Error in any_missing_numeric: x is not integer or double");
    }
}

miss_t any_missing_complex(SEXP x) {
    const Rcomplex * xp = COMPLEX(x);
    const Rcomplex * const xe = xp + xlength(x);
    for (; xp != xe; xp++) {
        if (ISNAN((*xp).r) || ISNAN((*xp).i))
            return MISS_COMPLEX;
    }
    return MISS_NONE;
}

miss_t any_missing_string(SEXP x) {
    const R_xlen_t nx = xlength(x);
    for (R_xlen_t i = 0; i < nx; i++) {
        if (STRING_ELT(x, i) == NA_STRING)
            return MISS_CHARACTER;
    }
    return MISS_NONE;
}

miss_t any_missing_atomic(SEXP x) {
    switch(TYPEOF(x)) {
        case LGLSXP:  return any_missing_logical(x);
        case INTSXP:  return any_missing_integer(x);
        case REALSXP: return any_missing_double(x);
        case CPLXSXP: return any_missing_complex(x);
        case STRSXP:  return any_missing_string(x);
        default:      return(MISS_NONE);
    }
}

miss_t any_missing_list(SEXP x) {
    const R_xlen_t nx = xlength(x);
    for (R_xlen_t i = 0; i < nx; i++) {
        if (isNull(VECTOR_ELT(x, i)))
            return MISS_LIST;
    }
    return MISS_NONE;
}

miss_t any_missing_matrix(SEXP x) {
    return any_missing_atomic(x);
}

miss_t any_missing_frame(SEXP x) {
    const R_xlen_t nc = xlength(x);
    miss_t type;
    for (R_xlen_t i = 0; i < nc; i++) {
        type = any_missing_atomic(VECTOR_ELT(x, i));
        if (type > MISS_NONE)
            return type;
    }
    return MISS_NONE;
}

SEXP c_any_missing(SEXP x) {
    miss_t res;
    switch(TYPEOF(x)) {
        case LGLSXP:  res = any_missing_logical(x); break;
        case INTSXP:  res = any_missing_integer(x); break;
        case REALSXP: res = any_missing_double(x); break;
        case CPLXSXP: res = any_missing_complex(x); break;
        case STRSXP:  res = any_missing_string(x); break;
        case NILSXP:  res = MISS_NONE; break;
        case VECSXP:  res = isFrame(x) ? any_missing_frame(x) : any_missing_list(x); break;
        case RAWSXP:  res = MISS_NONE; break;
        default: error("Object of type '%s' not supported", type2char(TYPEOF(x)));
    }
    return ScalarLogical(res > MISS_NONE);
}
