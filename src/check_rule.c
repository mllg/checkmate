#include "check_rule.h"

error_t check_rule(SEXP x, const checker_t *checker, const Rboolean phony) {
    error_t result;

    if (checker->class != NULL && !checker->class(x)) {
        result.ok = FALSE;
        if (phony) {
            snprintf(result.msg, MSGLEN,
                    "Must be of class '%s', not '%s'",
                    checker->phony_class, type2char(TYPEOF(x)));
        }
    } else if (checker->missing != NULL && checker->missing(x)) {
        result.ok = FALSE;
        if (phony) {
            snprintf(result.msg, MSGLEN,
                    "May not contain missing values");
        }
    } else if (checker->len != NULL && !checker->len(x, checker->cmp)) {
        result.ok = FALSE;
        if (phony) {
            snprintf(result.msg, MSGLEN,
                    "Must have length %s %i",
                    checker->phony_len, checker->cmp);
        }
    } else {
        result.ok = TRUE;
    }

    return result;
}
