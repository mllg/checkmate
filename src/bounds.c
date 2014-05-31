#include "bounds.h"
#include "assertions.h"

Rboolean dd_eq(const double x, const double y) { return x == y; }
Rboolean dd_lt(const double x, const double y) { return x <  y; }
Rboolean dd_gt(const double x, const double y) { return x >  y; }
Rboolean dd_le(const double x, const double y) { return x <= y; }
Rboolean dd_ge(const double x, const double y) { return x >= y; }
Rboolean dd_ne(const double x, const double y) { return x != y; }

inline const char* getOperatorString(const cmp_t op) {
    switch(op) {
        case LT: return "<";
        case LE: return "<=";
        case EQ: return "==";
        case GE: return ">=";
        case GT: return ">";
        case NE: return "!=";
        default: error("Internal error dispatching comparison operator");
    }
}

Rboolean is_in_bound(SEXP x, const bound_t bound) {
    if (isReal(x)) {
        const double *xp = REAL(x);
        const double * const xend = xp + length(x);
        for (; xp != xend; xp++) {
            if (!ISNAN(*xp) && !bound.fun(*xp, bound.cmp))
                return FALSE;
        }
    } else if (isInteger(x)) {
        const int *xp = INTEGER(x);
        const int * const xend = xp + length(x);
        for (; xp != xend; xp++) {
            if (*xp != NA_INTEGER && !bound.fun((double) *xp, bound.cmp))
                return FALSE;
        }
    } else {
        error("Bound checks only possible for numeric variables");
    }

    return TRUE;
}

msg_t check_bounds(SEXP x, SEXP lower, SEXP upper) {
    double tmp;

    assertNumber(lower, "lower");
    tmp = asReal(lower);
    if (R_FINITE(tmp)) {
        bound_t bound = { .cmp = tmp, .op = GE, .fun = &dd_ge };
        if (!is_in_bound(x, bound))
            return Msgf("All elements must be %s %f", getOperatorString(bound.op), bound.cmp);
    }

    assertNumber(lower, "upper");
    tmp = asReal(upper);
    if (R_FINITE(tmp)) {
        bound_t bound = { .cmp = tmp, .op = LE, .fun = &dd_le };
        if (!is_in_bound(x, bound))
            return Msgf("All elements must be %s %f", getOperatorString(bound.op), bound.cmp);
    }
    return MSGT;
}
