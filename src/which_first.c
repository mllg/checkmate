#include "which_first.h"
#include "backports.h"

static inline SEXP named_return(R_xlen_t ind, SEXP x, SEXP use_names) {
    if (!LOGICAL_RO(use_names)[0]) {
        return ScalarInteger(ind + 1);
    }

    SEXP names = PROTECT(getAttrib(x, R_NamesSymbol));
    if (isNull(names)) {
        UNPROTECT(1);
        return ScalarInteger(ind + 1);
    }

    SEXP res = PROTECT(ScalarInteger(ind + 1));
    setAttrib(res, R_NamesSymbol, ScalarString(STRING_ELT(names, ind)));
    UNPROTECT(2);
    return res;
}

SEXP attribute_hidden c_which_first(SEXP x, SEXP use_names) {
    if (!isLogical(x))
        error("Argument 'x' must be logical");
    if (!isLogical(use_names) || length(use_names) != 1)
        error("Argument 'use.names' must be a flag");
    const R_xlen_t n = xlength(x);
    const int *xp = LOGICAL_RO(x);

    for (R_xlen_t i = 0; i < n; i++) {
        if (xp[i] != NA_LOGICAL && xp[i]) {
            return named_return(i, x, use_names);
        }
    }
    return allocVector(INTSXP, 0);
}

SEXP attribute_hidden c_which_last(SEXP x, SEXP use_names) {
    if (!isLogical(x))
        error("Argument 'x' must be logical");
    if (!isLogical(use_names) || xlength(use_names) != 1)
        error("Argument 'use.names' must be a flag");
    const int *xp = LOGICAL_RO(x);

    for (R_xlen_t i = xlength(x) - 1; i >= 0; i--) {
        if (xp[i] != NA_LOGICAL && xp[i]) {
            return named_return(i, x, use_names);
        }
    }
    return allocVector(INTSXP, 0);
}
