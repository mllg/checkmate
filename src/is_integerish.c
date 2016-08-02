#include "is_integerish.h"
#include <math.h>
#include <limits.h>

static inline Rboolean is_unconvertible(const double x, const double tol) {
    return (!ISNAN(x) && (x <= INT_MIN || x > INT_MAX || fabs(x - nearbyint(x)) >= tol));
}

static Rboolean is_integerish_double(SEXP x, const double tol) {
    const double *xr = REAL(x);
    const double * const xend = xr + length(x);

    for (; xr != xend; xr++) {
        if (is_unconvertible(*xr, tol))
            return FALSE;
    }
    return TRUE;
}

static Rboolean is_integerish_complex(SEXP x, const double tol) {
    const Rcomplex * xc = COMPLEX(x);
    const Rcomplex * const xe = xc + length(x);
    for (; xc != xe; xc++) {
        if (fabs((*xc).i) >= tol || is_unconvertible((*xc).r, tol))
            return FALSE;
    }
    return TRUE;
}

Rboolean isIntegerish(SEXP x, const double tol, Rboolean logicals_ok) {
    switch(TYPEOF(x)) {
        case LGLSXP: return logicals_ok;
        case INTSXP: return TRUE;
        case REALSXP: return is_integerish_double(x, tol);
        case CPLXSXP: return is_integerish_complex(x, tol);
    }
    return FALSE;
}

SEXP c_is_integerish(SEXP x, SEXP tolerance) {
    return ScalarLogical(isIntegerish(x, REAL(tolerance)[0], FALSE));
}
