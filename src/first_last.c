#include "first_last.h"

static inline SEXP named_return(R_len_t ind, SEXP names) {
    SEXP res;
    PROTECT(res = ScalarInteger(ind + 1));
    if (!isNull(names))
        SET_NAMES(res, ScalarString(STRING_ELT(names, ind)));
    UNPROTECT(1);
    return res;
}

SEXP c_first(SEXP x, SEXP use_names) {
    if (!isLogical(x))
        error("Argument 'x' must be logical");
    if (!isLogical(use_names) || length(use_names) != 1)
        error("Argument 'use_names' must be single logical value");
    const R_len_t n = length(x);
    int *xp = LOGICAL(x);

    for (R_len_t i = 0; i < n; i++) {
        if (xp[i] != NA_LOGICAL && xp[i]) {
            if (LOGICAL(use_names)[0])
                return named_return(i, GET_NAMES(x));
            else
                return ScalarInteger(i+1);
        }
    }
    return allocVector(INTSXP, 0);
}

SEXP c_last(SEXP x, SEXP use_names) {
    if (!isLogical(x))
        error("Argument 'x' must be logical");
    if (!isLogical(use_names) || length(use_names) != 1)
        error("Argument 'use_names' must be single logical value");
    int *xp = LOGICAL(x);

    for (R_len_t i = length(x) - 1; i >= 0; i--) {
        if (xp[i] != NA_LOGICAL && xp[i]) {
            if (LOGICAL(use_names)[0])
                return named_return(i, GET_NAMES(x));
            else
                return ScalarInteger(i+1);
        }
    }
    return allocVector(INTSXP, 0);
}
