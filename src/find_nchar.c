#include "find_nchar.h"

typedef Rboolean(*cm_ll_cmp)(R_xlen_t, R_xlen_t);
static inline Rboolean ii_eq(const R_xlen_t x, const R_xlen_t y) { return x == y; }
static inline Rboolean ii_le(const R_xlen_t x, const R_xlen_t y) { return x <= y; }
static inline Rboolean ii_ge(const R_xlen_t x, const R_xlen_t y) { return x >= y; }

R_xlen_t get_nchars(SEXP x, R_xlen_t i) {
   return R_nchar(STRING_ELT(x, i), Chars, TRUE, TRUE, "character vector");
}

static R_xlen_t check_nchar(SEXP x, R_xlen_t n, cm_ll_cmp cmp) {
    if (!isString(x)) {
        SEXP xs = PROTECT(coerceVector(x, STRSXP));
        R_xlen_t res = check_nchar(xs, n, cmp);
        UNPROTECT(1);
        return res;
    }

    const R_xlen_t nx = xlength(x);
    for (R_xlen_t i = 0; i < nx; i++) {
        R_xlen_t nchars = get_nchars(x, i);
        if (nchars != NA_INTEGER && !(*cmp)(nchars, n)) {
            return i + 1;
        }
    }

    return 0;
}


R_xlen_t find_nchar(SEXP x, R_xlen_t n) {
    return check_nchar(x, n, &ii_eq);
}

R_xlen_t find_min_nchar(SEXP x, R_xlen_t n) {
    return check_nchar(x, n, &ii_ge);
}

R_xlen_t find_max_nchar(SEXP x, R_xlen_t n) {
    return check_nchar(x, n, &ii_le);
}
