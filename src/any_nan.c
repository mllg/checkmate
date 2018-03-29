#include "any_nan.h"
#include "backports.h"

static Rboolean any_nan_double(SEXP x) {
    const double * xp = REAL_RO(x);
    const double * const xe = xp + xlength(x);
    for (; xp != xe; xp++) {
        if (R_IsNaN(*xp))
            return TRUE;
    }
    return FALSE;
}

static Rboolean any_nan_complex(SEXP x) {
    const Rcomplex * xp = COMPLEX_RO(x);
    const Rcomplex * const xe = xp + xlength(x);
    for (; xp != xe; xp++) {
        if (R_IsNaN((*xp).r) || R_IsNaN((*xp).i))
            return TRUE;
    }
    return FALSE;
}

static Rboolean any_nan_list(SEXP x) {
    const R_xlen_t nx = xlength(x);
    for (R_xlen_t i = 0; i < nx; i++) {
        if (any_nan(VECTOR_ELT(x, i)))
            return TRUE;
    }
    return FALSE;
}

Rboolean any_nan(SEXP x) {
    switch(TYPEOF(x)) {
        case REALSXP: return any_nan_double(x);
        case CPLXSXP: return any_nan_complex(x);
        case VECSXP:  return any_nan_list(x);
    }
    return FALSE;
}

SEXP attribute_hidden c_any_nan(SEXP x) {
    return ScalarLogical(any_nan(x));
}
