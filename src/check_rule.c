#include "check_rule.h"

static const char* getClassString(const class_t name) {
    switch(name) {
        case CL_LOGICAL     : return "logical";
        case CL_INTEGER     : return "integer";
        case CL_INTEGERISH  : return "integerish";
        case CL_NUMERIC     : return "numeric";
        case CL_DOUBLE      : return "double";
        case CL_STRING      : return "string";
        case CL_LIST        : return "list";
        case CL_COMPLEX     : return "complex";
        case CL_ATOMIC      : return "atomic";
        case CL_MATRIX      : return "matrix";
        case CL_DATAFRAME   : return "data frame";
        case CL_ENVIRONMENT : return "environment";
        case CL_FUNCTION    : return "function";
        case CL_NULL        : return "NULL";
        default             : error("Internal error dispatching class");
    }
}

static const char* getOperatorString(const comp_t op) {
    switch(op) {
        case LT: return "<";
        case LE: return "<=";
        case EQ: return "==";
        case GE: return ">=";
        case GT: return ">";
        default: error("Internal error dispatching comparison operator");
    }
}

static Rboolean check_bound(SEXP x, bound_t bound) {
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

error_t check_rule(SEXP x, const checker_t *checker, const Rboolean err_msg) {
    error_t result;

    if (checker->class.fun != NULL && !checker->class.fun(x)) {
        result.ok = FALSE;
        if (err_msg) {
            snprintf(result.msg, MSGLEN, "Must be of class '%s', not '%s'",
                    /* FIXME factors are printed as integers */
                    getClassString(checker->class.name), type2char(TYPEOF(x)));
        }
        return result;
    }

    if (checker->missing.fun != NULL && checker->missing.fun(x)) {
        result.ok = FALSE;
        if (err_msg) {
            snprintf(result.msg, MSGLEN, "May not contain missing values");
        }
        return result;
    }

    if (checker->len.fun != NULL && !checker->len.fun(length(x), checker->len.cmp)) {
        result.ok = FALSE;
        if (err_msg) {
            snprintf(result.msg, MSGLEN, "Must be of length %s %i, but has length %i",
                     getOperatorString(checker->len.op), checker->len.cmp, length(x));
        }
        return result;
    }

    if (checker->lower.fun != NULL && !check_bound(x, checker->lower)) {
        result.ok = FALSE;
        if (err_msg) {
            snprintf(result.msg, MSGLEN, "All elements must be %s %f",
                    getOperatorString(checker->lower.op), checker->lower.cmp);
        }
        return result;
    }

    if (checker->upper.fun != NULL && !check_bound(x, checker->upper)) {
        result.ok = FALSE;
        if (err_msg) {
            snprintf(result.msg, MSGLEN, "All elements must be %s %f",
                    getOperatorString(checker->upper.op), checker->upper.cmp);
        }
        return result;
    }

    result.ok = TRUE;
    return result;
}
