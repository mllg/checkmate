#include "all_missing.h"
#include "backports.h"

Rboolean attribute_hidden all_missing_logical(SEXP x) {
#if defined(R_VERSION) && R_VERSION >= R_Version(3, 6, 0)
    if (LOGICAL_NO_NA(x))
        return FALSE;
#endif
    const int * xp = LOGICAL_RO(x);
    const int * const xe = xp + xlength(x);
    for (; xp != xe; xp++) {
        if (*xp != NA_LOGICAL)
            return FALSE;
    }
    return TRUE;
}

Rboolean attribute_hidden all_missing_integer(SEXP x) {
#if defined(R_VERSION) && R_VERSION >= R_Version(3, 5, 0)
    if (INTEGER_NO_NA(x))
        return FALSE;
#endif
    const int * xp = INTEGER_RO(x);
    const int * const xe = xp + xlength(x);
    for (; xp != xe; xp++) {
        if (*xp != NA_INTEGER)
            return FALSE;
    }
    return TRUE;
}

Rboolean attribute_hidden all_missing_double(SEXP x) {
#if defined(R_VERSION) && R_VERSION >= R_Version(3, 5, 0)
    if (REAL_NO_NA(x))
        return FALSE;
#endif
    const double * xp = REAL_RO(x);
    const double * const xe = xp + xlength(x);
    for (; xp != xe; xp++) {
        if (!ISNAN(*xp))
            return FALSE;
    }
    return TRUE;
}

Rboolean attribute_hidden all_missing_complex(SEXP x) {
    const Rcomplex * xp = COMPLEX_RO(x);
    const Rcomplex * const xe = xp + xlength(x);
    for (; xp != xe; xp++) {
        if (!ISNAN((*xp).r) && !ISNAN((*xp).i))
            return FALSE;
    }
    return TRUE;
}

Rboolean attribute_hidden all_missing_string(SEXP x) {
#if defined(R_VERSION) && R_VERSION >= R_Version(3, 5, 0)
    if (STRING_NO_NA(x))
        return FALSE;
#endif
    const R_xlen_t nx = xlength(x);
    for (R_xlen_t i = 0; i < nx; i++) {
        if (STRING_ELT(x, i) != NA_STRING)
            return FALSE;
    }
    return TRUE;
}

Rboolean attribute_hidden all_missing_atomic(SEXP x) {
    switch(TYPEOF(x)) {
        case LGLSXP: return all_missing_logical(x);
        case INTSXP: return all_missing_integer(x);
        case REALSXP: return all_missing_double(x);
        case CPLXSXP: return all_missing_complex(x);
        case STRSXP: return all_missing_string(x);
        case VECSXP: return all_missing_list(x);
        default: return FALSE;
    }
}

Rboolean attribute_hidden all_missing_list(SEXP x) {
    const R_xlen_t nx = xlength(x);
    for (R_xlen_t i = 0; i < nx; i++) {
        if (!isNull(VECTOR_ELT(x, i)))
            return FALSE;
    }
    return TRUE;
}

Rboolean attribute_hidden all_missing_frame(SEXP x) {
    const R_xlen_t nc = xlength(x);
    for (R_xlen_t i = 0; i < nc; i++) {
        SEXP xi = VECTOR_ELT(x, i);
        if (TYPEOF(xi) != VECSXP && all_missing_atomic(xi))
            return TRUE;
    }
    return FALSE;
}

Rboolean attribute_hidden all_missing(SEXP x) {
    switch(TYPEOF(x)) {
        case LGLSXP: return all_missing_logical(x);
        case INTSXP: return all_missing_integer(x);
        case REALSXP: return all_missing_double(x);
        case CPLXSXP: return all_missing_complex(x);
        case STRSXP: return all_missing_string(x);
        case NILSXP: return FALSE;
        case VECSXP: return isDataFrame(x) ? all_missing_frame(x) : all_missing_list(x);
        case RAWSXP: return FALSE;
        default: error("Object of type '%s' not supported", type2char(TYPEOF(x)));
    }
}

SEXP attribute_hidden c_all_missing(SEXP x) {
    return ScalarLogical(all_missing(x));
}
