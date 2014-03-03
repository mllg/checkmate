#include "is_constant.h"
#include <math.h>

SEXP c_is_constant(SEXP x, SEXP tolerance) {
    const double *xr = REAL(x);
    const double * const first = xr;
    const double * const last = xr + length(x);
    const double tol = REAL(tolerance)[0];
    for (xr++; xr != last; xr++) {
        if (fabs(*xr - *first) > tol)
            return ScalarLogical(FALSE);
    }
    return ScalarLogical(TRUE);
}
