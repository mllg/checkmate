#include "all_nchar.h"

Rboolean all_nchar(SEXP x, const R_xlen_t n) {
    if (!isString(x)) {
        SEXP xs = PROTECT(coerceVector(x, STRSXP));
        Rboolean res = all_nchar(xs, n);
        UNPROTECT(1);
        return res;
    }

    const R_xlen_t nx = xlength(x);
    for (R_xlen_t i = 0; i < nx; i++) {
        if (STRING_ELT(x, i) == NA_STRING || xlength(STRING_ELT(x, i)) < n)
            return FALSE;
    }
    return TRUE;
}
