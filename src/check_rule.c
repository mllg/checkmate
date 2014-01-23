#include "check_rule.h"

static Rboolean in_bounds(SEXP x, const dd_cmp fun, const double cmp) {
    const R_len_t n = length(x);
    switch(TYPEOF(x)) {
        case INTSXP:
            for (R_len_t i = 0; i < n; i++) {
                if (!fun((double)INTEGER(x)[i], cmp))
                    return FALSE;
            }
            break;
        case REALSXP:
            for (R_len_t i = 0; i < n; i++) {
                if (!fun(REAL(x)[i], cmp))
                    return FALSE;
            }
            break;
        default:
            error("Bound check not supported for this type");
    }

    return TRUE;
}

error_t check_rule(SEXP x, const checker_t *checker, const Rboolean phony) {
    error_t result;

    if (checker->class.fun != NULL && !checker->class.fun(x)) {
        result.ok = FALSE;
        if (phony) {
            snprintf(result.msg, MSGLEN,
                    "Must be of class '%s', not '%s'",
                    checker->class.phony, type2char(TYPEOF(x)));
        }
        return result;
    }

    if (checker->missing.fun != NULL && checker->missing.fun(x)) {
        result.ok = FALSE;
        if (phony) {
            snprintf(result.msg, MSGLEN,
                    "May not contain missing values");
        }
        return result;
    }

    if (checker->len.fun != NULL && !checker->len.fun(length(x), checker->len.cmp)) {
        result.ok = FALSE;
        if (phony) {
            snprintf(result.msg, MSGLEN,
                    "Must have length %s %i",
                    checker->len.phony, checker->len.cmp);
        }
        return result;
    }

    if (checker->lower.fun != NULL && !in_bounds(x, checker->lower.fun, checker->lower.cmp)) {
        result.ok = FALSE;
        if (phony) {
            snprintf(result.msg, MSGLEN, "All elements must be %s %.2f", checker->lower.phony, checker->lower.cmp);
        }
        return result;
    }

    if (checker->upper.fun != NULL && !in_bounds(x, checker->upper.fun, checker->upper.cmp)) {
        result.ok = FALSE;
        if (phony) {
            snprintf(result.msg, MSGLEN, "All elements must be %s %.02f", checker->upper.phony, checker->upper.cmp);
        }
        return result;
    }

    result.ok = TRUE;
    return result;
}
