#include "which_first.h"

SEXP c_which_first(SEXP x) {
    if (!isLogical(x))
        error("Argument 'x' must be logical");
    const R_xlen_t n = xlength(x);
    const int *xp = LOGICAL(x);
    for (R_xlen_t i = 0; i < n; i++) {
        if (xp[i] != NA_LOGICAL && xp[i])
            return ScalarInteger(i+1);
    }
    return allocVector(INTSXP, 0);
}

SEXP c_which_last(SEXP x) {
    if (!isLogical(x))
        error("Argument 'x' must be logical");
    const R_xlen_t n = xlength(x);
    const int *xp = LOGICAL(x);
    for (R_xlen_t i = n - 1; i >= 0; i--) {
        if (xp[i] != NA_LOGICAL && xp[i])
            return ScalarInteger(i+1);
    }
    return allocVector(INTSXP, 0);
}
