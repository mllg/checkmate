#include <math.h>
#include <limits.h>
#include "integerish.h"
#include "backports.h"
#include "all_missing.h"

static inline int_err_t check_convertible_logical(SEXP x, Rboolean logicals_ok) {
    int_err_t res = { 0, (logicals_ok || all_missing_logical(x)) ? INT_OK : INT_TYPE };
    return res;
}

static inline int_check_t is_unconvertible_double(const double x, const double tol) {
    if (!ISNAN(x)) {
        if (x <= INT_MIN || x > INT_MAX)
            return INT_RANGE;
        if (fabs(x - nearbyint(x)) >= tol)
            return INT_TOL;
    }
    return INT_OK;
}

static int_err_t check_convertible_double(SEXP x, const double tol) {
    const double *xr = REAL_RO(x);
    const R_xlen_t n = length(x);
    int_err_t res = { 0, INT_OK };

    for (R_xlen_t i = 0; i < n; i++) {
        res.err = is_unconvertible_double(xr[i], tol);
        if (res.err != INT_OK) {
            res.pos = i + 1;
            break;
        }
    }
    return res;
}

static inline int_check_t is_unconvertible_complex(Rcomplex x, const double tol) {
    if (!ISNAN(x.i) && fabs(x.i) > tol)
        return INT_COMPLEX;
    return is_unconvertible_double(x.r, tol);
}

static int_err_t check_convertible_complex(SEXP x, const double tol) {
    const Rcomplex * xc = COMPLEX_RO(x);
    const R_xlen_t n = length(x);
    int_err_t res = { 0, INT_OK };

    for (R_xlen_t i = 0; i < n; i++) {
        int_check_t ok = is_unconvertible_complex(xc[i], tol);
        if (ok != INT_OK) {
            res.pos = i + 1; res.err = ok;
            break;
        }
    }
    return res;
}

int_err_t checkIntegerish(SEXP x, const double tol, Rboolean logicals_ok) {
    int_err_t res = { 0, INT_OK};
    switch(TYPEOF(x)) {
        case INTSXP: if (inherits(x, "factor")) res.err = INT_TYPE; break;
        case LGLSXP: res = check_convertible_logical(x, logicals_ok); break;
        case REALSXP: res = check_convertible_double(x, tol); break;
        case CPLXSXP: res = check_convertible_complex(x, tol); break;
        default: res.err = INT_TYPE;
    }
    return res;
}

Rboolean isIntegerish(SEXP x, const double tol, Rboolean logicals_ok) {
    int_err_t res = checkIntegerish(x, tol, logicals_ok);
    return res.err == INT_OK;
}

SEXP attribute_hidden c_is_integerish(SEXP x, SEXP tolerance) {
    return ScalarLogical(isIntegerish(x, REAL_RO(tolerance)[0], FALSE));
}
