#include "find_min_nchar.h"

R_xlen_t find_min_nchar(SEXP x, R_xlen_t n, Rboolean skip_na) {
    if (!isString(x)) {
        SEXP xs = PROTECT(coerceVector(x, STRSXP));
        Rboolean res = find_min_nchar(xs, n, skip_na);
        UNPROTECT(1);
        return res;
    }

    const R_xlen_t nx = xlength(x);
    for (R_xlen_t i = 0; i < nx; i++) {
        if (STRING_ELT(x, i) == NA_STRING) {
            if (skip_na) continue;
            return i + 1;
        }
        if (xlength(STRING_ELT(x, i)) < n) {
            return i + 1;
        }
    }
    return 0;
}
