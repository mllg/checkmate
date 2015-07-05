#include "all_missing.h"

Rboolean all_missing_logical(SEXP x) {
    const int * xp = LOGICAL(x);
    const int * const xe = xp + xlength(x);
    for (; xp != xe; xp++) {
        if (*xp != NA_LOGICAL)
            return FALSE;
    }
    return TRUE;
}

Rboolean all_missing_integer(SEXP x) {
    const int * xp = INTEGER(x);
    const int * const xe = xp + xlength(x);
    for (; xp != xe; xp++) {
        if (*xp != NA_INTEGER)
            return FALSE;
    }
    return TRUE;
}

Rboolean all_missing_double(SEXP x) {
    const double * xp = REAL(x);
    const double * const xe = xp + xlength(x);
    for (; xp != xe; xp++) {
        if (!ISNAN(*xp))
            return FALSE;
    }
    return TRUE;
}

Rboolean all_missing_complex(SEXP x) {
    const Rcomplex * xp = COMPLEX(x);
    const Rcomplex * const xe = xp + xlength(x);
    for (; xp != xe; xp++) {
        if (!ISNAN((*xp).r) || !ISNAN((*xp).i))
            return FALSE;
    }
    return TRUE;
}

Rboolean all_missing_string(SEXP x) {
    const R_xlen_t nx = xlength(x);
    for (R_xlen_t i = 0; i < nx; i++) {
        if (STRING_ELT(x, i) != NA_STRING)
            return FALSE;
    }
    return TRUE;
}

Rboolean all_missing_atomic(SEXP x) {
    switch(TYPEOF(x)) {
        case LGLSXP: return all_missing_logical(x);
        case INTSXP: return all_missing_integer(x);
        case REALSXP: return all_missing_double(x);
        case CPLXSXP: return all_missing_complex(x);
        case STRSXP: return all_missing_string(x);
        default: return FALSE;
    }
}

Rboolean all_missing_list(SEXP x) {
    const R_xlen_t nx = xlength(x);
    for (R_xlen_t i = 0; i < nx; i++) {
        if (!isNull(VECTOR_ELT(x, i)))
            return FALSE;
    }
    return TRUE;
}

Rboolean all_missing_frame(SEXP x) {
    const R_xlen_t nc = xlength(x);
    for (R_xlen_t i = 0; i < nc; i++) {
        if (all_missing_atomic(VECTOR_ELT(x, i)))
            return TRUE;
    }
    return FALSE;
}

Rboolean all_missing(SEXP x) {
    switch(TYPEOF(x)) {
        case LGLSXP: return all_missing_logical(x);
        case INTSXP: return all_missing_integer(x);
        case REALSXP: return all_missing_double(x);
        case CPLXSXP: return all_missing_complex(x);
        case STRSXP: return all_missing_string(x);
        case NILSXP: return FALSE;
        case VECSXP: return isFrame(x) ? all_missing_frame(x) : all_missing_list(x);
        case RAWSXP: return FALSE;
        default: error("Object of type '%s' not supported", type2char(TYPEOF(x)));
    }
}

SEXP c_all_missing(SEXP x) {
    return ScalarLogical(all_missing(x));
}
