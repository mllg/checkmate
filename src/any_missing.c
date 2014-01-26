#include "any_missing.h"

inline Rboolean any_missing_logical(SEXP x) {
    const int * xp = LOGICAL(x);
    const int * const xe = xp + length(x);
    for (; xp != xe; xp++) {
        if (*xp == NA_LOGICAL)
            return TRUE;
    }
    return FALSE;
}

inline Rboolean any_missing_integer(SEXP x) {
    const int * xp = INTEGER(x);
    const int * const xe = xp + length(x);
    for (; xp != xe; xp++) {
        if (*xp == NA_INTEGER)
            return TRUE;
    }
    return FALSE;
}

inline Rboolean any_missing_double(SEXP x) {
    const double * xp = REAL(x);
    const double * const xe = xp + length(x);
    for (; xp != xe; xp++) {
        if (ISNAN(*xp))
            return TRUE;
    }
    return FALSE;
}

inline Rboolean any_missing_numeric(SEXP x) {
    switch(TYPEOF(x)) {
        case INTSXP: return any_missing_integer(x);
        case REALSXP: return any_missing_double(x);
        default: error("Error in any_missing_numeric: x is not integer or real");
    }
}

inline Rboolean any_missing_complex(SEXP x) {
    const Rcomplex * xp = COMPLEX(x);
    const Rcomplex * const xe = xp + length(x);
    for (; xp != xe; xp++) {
        if (ISNAN((*xp).r) || ISNAN((*xp).i))
            return TRUE;
    }
    return FALSE;
}

inline Rboolean any_missing_string(SEXP x) {
    const R_len_t nx = length(x);
    for (R_len_t i = 0; i < nx; i++) {
        if (STRING_ELT(x, i) == NA_STRING)
            return TRUE;
    }
    return FALSE;
}

inline Rboolean any_missing_atomic(SEXP x) {
    switch(TYPEOF(x)) {
        case LGLSXP: return any_missing_logical(x);
        case INTSXP: return any_missing_integer(x);
        case REALSXP: return any_missing_double(x);
        case CPLXSXP: return any_missing_complex(x);
        case STRSXP: return any_missing_string(x);
        case RAWSXP: return FALSE;
        default: error("Object of type '%s' not atomic", type2char(TYPEOF(x)));
    }
    return FALSE;
}

inline Rboolean any_missing_list(SEXP x) {
    const R_len_t nx = length(x);
    for (R_len_t i = 0; i < nx; i++) {
        if (isNull(VECTOR_ELT(x, i)))
            return TRUE;
    }
    return FALSE;
}

inline Rboolean any_missing_matrix(SEXP x) {
    return any_missing_atomic(x);
}

inline Rboolean any_missing_frame(SEXP x) {
    const R_len_t nc = length(x);
    for (R_len_t i = 0; i < nc; i++) {
        if (any_missing_atomic(VECTOR_ELT(x, i)))
            return TRUE;
    }
    return FALSE;
}

static inline Rboolean any_missing(SEXP x) {
    switch(TYPEOF(x)) {
        case LGLSXP: return any_missing_logical(x);
        case INTSXP: return any_missing_integer(x);
        case REALSXP: return any_missing_double(x);
        case CPLXSXP: return any_missing_complex(x);
        case STRSXP: return any_missing_string(x);
        case NILSXP: return FALSE;
        case VECSXP: return isFrame(x) ? any_missing_frame(x) : any_missing_list(x);
        case RAWSXP: return FALSE;
        default: error("Object of type '%s' not supported", type2char(TYPEOF(x)));
    }
}

SEXP c_any_missing(SEXP x) {
    return ScalarLogical(any_missing(x));
}
