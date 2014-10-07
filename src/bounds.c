#include "bounds.h"
#include "as_type.h"

static inline msg_t boundError(bound_t bound) {
    return Msgf("All elements must be %s %g", CMPSTR[bound.op], bound.cmp);
}

msg_t check_bound(SEXP x, const bound_t bound) {
    if (isReal(x)) {
        const double *xp = REAL(x);
        const double * const xend = xp + length(x);
        for (; xp != xend; xp++) {
            if (!ISNAN(*xp) && !bound.fun(*xp, bound.cmp))
                return boundError(bound);
        }
    } else if (isInteger(x)) {
        const int *xp = INTEGER(x);
        const int * const xend = xp + length(x);
        for (; xp != xend; xp++) {
            if (*xp != NA_INTEGER && !bound.fun((double) *xp, bound.cmp))
                return boundError(bound);
        }
    } else {
        error("Bound checks only possible for numeric variables");
    }

    return MSGT;
}

msg_t check_bounds(SEXP x, SEXP lower, SEXP upper) {
    double tmp;

    tmp = asNumber(lower, "lower");
    if (R_FINITE(tmp)) {
        bound_t bound = { .cmp = tmp, .op = GE, .fun = &dd_ge };
        msg_t msg = check_bound(x, bound);
        if (!msg.ok)
            return boundError(bound);
    }

    tmp = asNumber(upper, "upper");
    if (R_FINITE(tmp)) {
        bound_t bound = { .cmp = tmp, .op = LE, .fun = &dd_le };
        msg_t msg = check_bound(x, bound);
        if (!msg.ok)
            return boundError(bound);
    }
    return MSGT;
}
