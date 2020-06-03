#include "is_sorted.h"
#include "backports.h"

static Rboolean is_sorted_integer(SEXP x) {
#if defined(R_VERSION) && R_VERSION >= R_Version(3, 5, 0)
    int sorted = INTEGER_IS_SORTED(x);
    if (sorted != UNKNOWN_SORTEDNESS)
        return KNOWN_INCR(sorted);
#endif
    R_xlen_t i = 0;
    const R_xlen_t n = xlength(x);
    const int * const xi = INTEGER_RO(x);
    while(i < n && xi[i] == NA_INTEGER) i++;

    for (R_xlen_t j = i + 1; j < n; j++) {
        if (xi[j] != NA_INTEGER) {
            if (xi[i] > xi[j])
                return FALSE;
            i = j;
        }
    }
    return TRUE;
}

static Rboolean is_sorted_double(SEXP x) {
#if defined(R_VERSION) && R_VERSION >= R_Version(3, 5, 0)
    int sorted = REAL_IS_SORTED(x);
    if (sorted != UNKNOWN_SORTEDNESS)
        return KNOWN_INCR(sorted);
#endif
    R_xlen_t i = 0;
    const R_xlen_t n = xlength(x);
    const double * const xr = REAL_RO(x);
    while(i < n && xr[i] == NA_REAL) i++;

    for (R_xlen_t j = i + 1; j < n; j++) {
        if (xr[j] != NA_REAL) {
            if (xr[i] > xr[j])
                return FALSE;
            i = j;
        }
    }
    return TRUE;
}

static Rboolean is_sorted_character(SEXP x) {
#if defined(R_VERSION) && R_VERSION >= R_Version(3, 5, 0)
    int sorted = STRING_IS_SORTED(x);
    if (sorted != UNKNOWN_SORTEDNESS)
        return KNOWN_INCR(sorted);
#endif
    const R_xlen_t n = length(x);
    R_xlen_t i = 0;
    SEXP xi, xj;

    while(i < n) {
        xi = STRING_ELT(x, i);
        if (xi != NA_STRING)
            break;
    }

    for (R_xlen_t j = i + 1; j < n; j++) {
        xj = STRING_ELT(x, j);
        if (xj != NA_STRING) {
            if (strcmp(CHAR(xi), CHAR(xj)) > 0)
                return FALSE;
            xi = xj;
        }
    }
    return TRUE;
}

Rboolean is_sorted(SEXP x) {
    switch(TYPEOF(x)) {
        case INTSXP: return is_sorted_integer(x);
        case REALSXP: return is_sorted_double(x);
        case STRSXP: return is_sorted_character(x);
        default: error("Checking for sorted vector only possible for integer and double");
    }
}
