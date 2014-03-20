#include "is_integerish.h"
#include <math.h>
#include <limits.h>

Rboolean isIntegerish(SEXP x, const double tol) {
    if (isInteger(x) || isLogical(x))
        return TRUE;
    if (! isReal(x))
        return FALSE;
    const double *xr = REAL(x);
    const double * const xend = xr + length(x);

    for (; xr != xend; xr++) {
        if (!ISNAN(*xr) && (*xr <= INT_MIN || *xr > INT_MAX || fabs(*xr - nearbyint(*xr)) >= tol))
            return FALSE;
    }
    return TRUE;
}

SEXP c_is_integerish(SEXP x, SEXP tolerance) {
    return ScalarLogical(isIntegerish(x, REAL(tolerance)[0]));
}
