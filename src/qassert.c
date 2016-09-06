#include "qassert.h"
#include "helper.h"
#include "guess_type.h"
#include "any_missing.h"
#include "is_integerish.h"

typedef enum {
    CL_LOGICAL, CL_INTEGER, CL_INTEGERISH, CL_NUMERIC, CL_DOUBLE, CL_STRING, CL_FACTOR, CL_LIST, CL_COMPLEX,
    CL_ATOMIC, CL_ATOMIC_VECTOR, CL_MATRIX, CL_DATAFRAME, CL_FUNCTION, CL_ENVIRONMENT, CL_NULL, CL_NONE
} class_t;

static const char * CLSTR[] = {
     "logical", "integer", "integerish", "numeric", "double", "string", "factor", "list", "complex",
     "atomic", "atomic vector", "matrix", "data frame", "function", "environment", "NULL"
};

typedef enum { LT, LE, EQ, GE, GT, NE, NONE } cmp_t;
static const char * CMPSTR[] = { "<", "<=", "==", ">=", ">", "!=" };

typedef Rboolean(*dd_cmp)(double, double);
typedef Rboolean(*ll_cmp)(R_xlen_t, R_xlen_t);
typedef struct { dd_cmp fun; double cmp; cmp_t op; } bound_t;

typedef struct {
    struct {
        Rboolean(*fun)(SEXP);
        class_t name;
    } class;
    struct {
        Rboolean(*fun)(SEXP);
    } missing;
    struct {
        ll_cmp fun;
        R_xlen_t cmp;
        cmp_t op;
    } len;
    bound_t lower;
    bound_t upper;
} checker_t;

typedef struct {
    Rboolean ok;
    char msg[255];
} msg_t;


static inline Rboolean ii_eq(const R_xlen_t x, const R_xlen_t y) { return x == y; }
static inline Rboolean ii_lt(const R_xlen_t x, const R_xlen_t y) { return x <  y; }
static inline Rboolean ii_gt(const R_xlen_t x, const R_xlen_t y) { return x >  y; }
static inline Rboolean ii_le(const R_xlen_t x, const R_xlen_t y) { return x <= y; }
static inline Rboolean ii_ge(const R_xlen_t x, const R_xlen_t y) { return x >= y; }
static inline Rboolean dd_lt(const double x, const double y) { return x <  y; }
static inline Rboolean dd_gt(const double x, const double y) { return x >  y; }
static inline Rboolean dd_le(const double x, const double y) { return x <= y; }
static inline Rboolean dd_ge(const double x, const double y) { return x >= y; }
static inline Rboolean dd_ne(const double x, const double y) { return x != y; }
static inline Rboolean is_class_logical(SEXP x) { return isLogical(x); }
static inline Rboolean is_class_integer(SEXP x) { return isInteger(x); }
static inline Rboolean is_class_integerish(SEXP x) { return isIntegerish(x, INTEGERISH_DEFAULT_TOL, TRUE); }
static inline Rboolean is_class_double(SEXP x) { return isReal(x); }
static inline Rboolean is_class_numeric(SEXP x) { return isStrictlyNumeric(x); }
static inline Rboolean is_class_complex(SEXP x) { return isComplex(x); }
static inline Rboolean is_class_string(SEXP x) { return isString(x); }
static inline Rboolean is_class_factor(SEXP x) { return isFactor(x); }
static inline Rboolean is_class_atomic(SEXP x) { return isNull(x) || isVectorAtomic(x); }
static inline Rboolean is_class_atomic_vector(SEXP x) { return isAtomicVector(x); }
static inline Rboolean is_class_list(SEXP x) { return isRList(x); }
static inline Rboolean is_class_matrix(SEXP x) { return isMatrix(x); }
static inline Rboolean is_class_frame(SEXP x) { return isFrame(x); }
static inline Rboolean is_class_function(SEXP x) { return isFunction(x); }
static inline Rboolean is_class_environment(SEXP x) { return isEnvironment(x); }
static inline Rboolean is_class_null(SEXP x) { return isNull(x); }

static const msg_t MSGT = { .ok = TRUE };
static const msg_t MSGF = { .ok = FALSE };

static msg_t message(const char *fmt, ...) {
    msg_t msg = { .ok = FALSE };
    va_list vargs;
    va_start(vargs, fmt);
    vsnprintf(msg.msg, 255, fmt, vargs);
    va_end(vargs);
    return msg;
}

/*********************************************************************************************************************/
/* Some helper functions                                                                                             */
/*********************************************************************************************************************/
static msg_t check_bound(SEXP x, const bound_t bound) {
    if (isReal(x)) {
        const double *xp = REAL(x);
        const double * const xend = xp + xlength(x);
        for (; xp != xend; xp++) {
            if (!ISNAN(*xp) && !bound.fun(*xp, bound.cmp)) {
                if (bound.cmp == R_PosInf)
                    return message("All elements must be %s Inf", CMPSTR[bound.op]);
                if (bound.cmp == R_NegInf)
                    return message("All elements must be %s -Inf", CMPSTR[bound.op]);
                return message("All elements must be %s %g", CMPSTR[bound.op], bound.cmp);
            }
        }
    } else if (isInteger(x)) {
        const int *xp = INTEGER(x);
        const int * const xend = xp + xlength(x);
        for (; xp != xend; xp++) {
            if (*xp != NA_INTEGER && !bound.fun((double) *xp, bound.cmp))
                return message("All elements must be %s %g", CMPSTR[bound.op], bound.cmp);
        }
    } else if (isString(x)) {
        const R_xlen_t nx = xlength(x);
        double nchar;
        for (R_xlen_t i = 0; i < nx; i++) {
            nchar = STRING_ELT(x, i) == NA_STRING ? 0. : (double)length(STRING_ELT(x, i));
            if (!bound.fun(nchar, bound.cmp))
                return message("All elements must have %s %g chars", CMPSTR[bound.op], bound.cmp);
        }
    } else if (isFactor(x)) {
        return check_bound(getAttrib(x, R_LevelsSymbol), bound);
    } else {
        error("Bound checks only possible for numeric variables, strings and factors, not %s", guess_type(x));
    }

    return MSGT;
}

/*********************************************************************************************************************/
/* First step: Parse string and built checker_t object                                                               */
/*********************************************************************************************************************/
static int parse_class(checker_t *checker, const char *rule) {
    checker->missing.fun = NULL;
    switch(rule[0]) {
        case 'B':
            checker->missing.fun = &any_missing_logical;
        case 'b':
            checker->class.fun = &is_class_logical;
            checker->class.name = CL_LOGICAL;
            break;
        case 'I':
            checker->missing.fun = &any_missing_integer;
        case 'i':
            checker->class.fun = &is_class_integer;
            checker->class.name = CL_INTEGER;
            break;
        case 'X':
            checker->missing.fun = &any_missing_integerish;
        case 'x':
            checker->class.fun = &is_class_integerish;
            checker->class.name = CL_INTEGERISH;
            break;
        case 'N':
            checker->missing.fun = &any_missing_numeric;
        case 'n':
            checker->class.fun = &is_class_numeric;
            checker->class.name = CL_NUMERIC;
            break;
        case 'R':
            checker->missing.fun = &any_missing_double;
        case 'r':
            checker->class.fun = &is_class_double;
            checker->class.name = CL_DOUBLE;
            break;
        case 'S':
            checker->missing.fun = &any_missing_string;
        case 's':
            checker->class.fun = &is_class_string;
            checker->class.name = CL_STRING;
            break;
        case 'F':
            checker->missing.fun = &any_missing_integer;
        case 'f':
            checker->class.fun = &is_class_factor;
            checker->class.name = CL_FACTOR;
            break;
        case 'L':
            checker->missing.fun = &any_missing_list;
        case 'l':
            checker->class.fun = &is_class_list;
            checker->class.name = CL_LIST;
            break;
        case 'C':
            checker->missing.fun = &any_missing_complex;
        case 'c':
            checker->class.fun = &is_class_complex;
            checker->class.name = CL_COMPLEX;
            break;
        case 'A':
            checker->missing.fun = &any_missing_atomic;
        case 'a':
            checker->class.fun = &is_class_atomic;
            checker->class.name = CL_ATOMIC;
            break;
        case 'V':
            checker->missing.fun = &any_missing_atomic;
        case 'v':
            checker->class.fun = &is_class_atomic_vector;
            checker->class.name = CL_ATOMIC_VECTOR;
            break;
        case 'M':
            checker->missing.fun = &any_missing_matrix;
        case 'm':
            checker->class.fun = &is_class_matrix;
            checker->class.name = CL_MATRIX;
            break;
        case 'D':
            checker->missing.fun = &any_missing_frame;
        case 'd':
            checker->class.fun = &is_class_frame;
            checker->class.name = CL_DATAFRAME;
            break;
        /* case 'g': */
        /*     checker->class.fun = &is_class_function; */
        /*     checker->class.name = CL_FUNCTION; */
        /*     break; */
        case 'e':
            checker->class.fun = &is_class_environment;
            checker->class.name = CL_ENVIRONMENT;
            break;
        case '0':
            checker->class.fun = &is_class_null;
            checker->class.name = CL_NULL;
            break;
        case '*':
            checker->class.fun = NULL;
            checker->class.name = CL_NONE;
            break;
        default:
            error("Unknown class identifier '%c'", rule[0]);
    }
    return 1;
}

static int parse_length(checker_t *checker, const char *rule) {
    switch(rule[0]) {
        case '*':
            checker->len.fun = NULL;
            return 1;
        case '?':
            checker->len.fun = &ii_le;
            checker->len.cmp = 1;
            checker->len.op = LE;
            return 1;
        case '+':
            checker->len.fun = &ii_ge;
            checker->len.cmp = 1;
            checker->len.op = GE;
            return 1;
        case '(':
        case '[':
        case '\0':
            checker->len.fun = NULL;
            checker->len.op = NONE;
            return 0;
    }

    const char *start = rule;
    switch(rule[0]) {
        case '=':
            checker->len.fun = &ii_eq;
            checker->len.op = EQ;
            start += 1 + (rule[1] == '=');
            break;
        case '<':
            if (rule[1] == '=') {
                checker->len.fun = &ii_le;
                checker->len.op = LE;
                start += 2;
            } else {
                checker->len.fun = &ii_lt;
                checker->len.op = LE;
                start += 1;
            }
            break;
        case '>':
            if (rule[1] == '=') {
                checker->len.fun = &ii_ge;
                checker->len.op = GE;
                start += 2;
            } else {
                checker->len.fun = &ii_gt;
                checker->len.op = GT;
                start += 1;
            }
            break;
        default:
            checker->len.fun = &ii_eq;
            checker->len.op = EQ;
            break;
    }

    char *end;
    long int cmp = strtol(start, &end, 10);
    if (start == end)
        error("Invalid length definition: %s", rule);
    if (cmp >= INT_MAX)
        error("Cannot handle length >= %i", INT_MAX);
    if (cmp < 0)
        error("Cannot check for negative length");

    checker->len.cmp = (int)cmp;
    return end - rule;
}

static int parse_bounds(checker_t *checker, const char *rule) {
    switch(rule[0]) {
        case '\0':
            checker->lower.fun = NULL;
            checker->upper.fun = NULL;
            return 0;
        case '(':
            checker->lower.fun = &dd_gt;
            checker->lower.op = GT;
            break;
        case '[':
            checker->lower.fun = &dd_ge;
            checker->lower.op = GE;
            break;
        default:
            error("Invalid bound definition, missing opening '(' or '[': %s", rule);
    }

    char *end;
    const char *start = rule + 1;
    double cmp = strtod(start, &end);
    if (start == end) {
        if (checker->lower.op == GT) {
            checker->lower.fun = &dd_ne;
            checker->lower.cmp = R_NegInf;
            checker->lower.op  = NE;
        } else {
            checker->lower.fun = NULL;
        }
    } else {
        checker->lower.cmp = cmp;
    }

    switch(*end) {
        case ',' : start = end + 1;
        case ')' :
        case ']' : break;
        default  : error("Invalid bound definition, error parsing lower bound, missing separator ',' or missing closing ')' or ']': %s", rule);
    }

    cmp = strtod(start, &end);
    if (*end == ')') {
        if (start == end) {
            checker->upper.fun = &dd_ne;
            checker->upper.cmp = R_PosInf;
            checker->upper.op = NE;
        } else {
            checker->upper.fun = &dd_lt;
            checker->upper.cmp = cmp;
            checker->upper.op = LT;
        }
    } else if (*end == ']') {
        if (start == end) {
            checker->upper.fun = NULL;
        } else {
            checker->upper.fun = &dd_le;
            checker->upper.cmp = cmp;
            checker->upper.op = LE;
        }
    } else {
        error("Invalid bound definition, error parsing upper bound or missing closing ')' or ']': %s", rule);
    }

    return end - rule + 1;
}

static void parse_rule(checker_t *checker, const char *rule) {
    const R_len_t nchars = strlen(rule);
    if (nchars == 0)
        error("Empty rule");

    rule += parse_class(checker, rule);
    rule += parse_length(checker, rule);
    rule += parse_bounds(checker, rule);
    if (rule[0] == '\0')
        return;
    error("Additional chars found!");
}

/*********************************************************************************************************************/
/* Second step: check SEXP using a checker_t object                                                                  */
/*********************************************************************************************************************/
static msg_t check_rule(SEXP x, const checker_t *checker, const Rboolean err_msg) {
    if (checker->class.fun != NULL && !checker->class.fun(x)) {
        return err_msg ? message("Must be of class '%s', not '%s'", CLSTR[checker->class.name], guess_type(x)) : MSGF;
    }

    if (checker->missing.fun != NULL && checker->missing.fun(x)) {
        return err_msg ? message("May not contain missing values") : MSGF;
    }

    if (checker->len.fun != NULL && !checker->len.fun(xlength(x), checker->len.cmp)) {
        return err_msg ? message("Must be of length %s %i, but has length %g", CMPSTR[checker->len.op], checker->len.cmp, (double)xlength(x)) : MSGF;
    }

    if (checker->lower.fun != NULL) {
        msg_t msg = check_bound(x, checker->lower);
        if (!msg.ok)
            return msg;
    }

    if (checker->upper.fun != NULL) {
        msg_t msg = check_bound(x, checker->upper);
        if (!msg.ok)
            return msg;
    }

    return MSGT;
}

/*********************************************************************************************************************/
/* qassert stuff                                                                                                     */
/*********************************************************************************************************************/
static inline R_len_t qassert1(SEXP x, const checker_t *checker, msg_t *result, const R_len_t nrules) {
    for (R_len_t i = 0; i < nrules; i++) {
        result[i] = check_rule(x, &checker[i], result[i].ok);
        if (result[i].ok)
            return 0;
    }
    return 1;
}

static inline R_len_t qassert_list(SEXP x, const checker_t *checker, msg_t *result, const R_len_t nrules) {
    if (!isNewList(x) || isNull(x))
        error("Argument 'x' must be a list or data.frame");

    const R_len_t nx = xlength(x);
    for (R_xlen_t i = 0; i < nx; i++) {
        if (qassert1(VECTOR_ELT(x, i), checker, result, nrules) != 0)
            return i + 1;
    }
    return 0;
}

/* exported for other packages */
SEXP qassert(SEXP x, const char *rule, const char *name) {
    checker_t checker;
    parse_rule(&checker, rule);
    msg_t result = check_rule(x, &checker, TRUE);
    if (!result.ok)
        error("Variable '%s': %s", name, result.msg);
    return x;
}

SEXP c_qassert(SEXP x, SEXP rules, SEXP recursive) {
    const Rboolean nrules = length(rules);
    R_len_t failed;
    if (!isString(rules))
        error("Argument 'rules' must be a string");
    if (nrules == 0)
        return ScalarLogical(TRUE);

    msg_t result[nrules];
    checker_t checker[nrules];
    SEXP tmp;
    for (R_len_t i = 0; i < nrules; i++) {
        tmp = STRING_ELT(rules, i);
        if (tmp == NA_STRING)
            error("Rule may not be NA");
        parse_rule(&checker[i], CHAR(tmp));
        result[i].ok = TRUE;
    }

    if (LOGICAL(recursive)[0]) {
        failed = qassert_list(x, checker, result, nrules);
    } else {
        failed = qassert1(x, checker, result, nrules);
    }

    if (failed == 0)
        return ScalarLogical(TRUE);

    SEXP msgs = PROTECT(allocVector(STRSXP, nrules));
    SEXP pos = PROTECT(ScalarInteger(failed));
    setAttrib(msgs, install("pos"), pos);
    for (R_len_t i = 0; i < nrules; i++)
        SET_STRING_ELT(msgs, i, mkChar(result[i].msg));
    UNPROTECT(2);
    return msgs;
}

/*********************************************************************************************************************/
/* qtest stuff                                                                                                       */
/*********************************************************************************************************************/
static inline Rboolean qtest1(SEXP x, const checker_t *checker, const R_len_t nrules) {
    msg_t result;
    for (R_len_t i = 0; i < nrules; i++) {
        result = check_rule(x, &checker[i], FALSE);
        if (result.ok)
            return TRUE;
    }
    return FALSE;
}

static inline Rboolean qtest_list(SEXP x, const checker_t *checker, const R_len_t nrules, R_len_t depth) {
    if (!isNewList(x) || isNull(x))
        error("Argument 'x' must be a list or data.frame");

    const R_len_t nx = xlength(x);
    if (depth > 1) {
        for (R_xlen_t i = 0; i < nx; i++) {
            if (isRList(VECTOR_ELT(x, i))) {
                if (!qtest_list(VECTOR_ELT(x, i), checker, nrules, depth - 1))
                    return FALSE;
            } else {
                if (!qtest1(VECTOR_ELT(x, i), checker, nrules))
                    return FALSE;
            }
        }
    } else {
        for (R_xlen_t i = 0; i < nx; i++) {
            if (!qtest1(VECTOR_ELT(x, i), checker, nrules))
                return FALSE;
        }
    }
    return TRUE;
}

/* exported for other packages */
Rboolean qtest(SEXP x, const char *rule) {
    checker_t checker;
    parse_rule(&checker, rule);
    return qtest1(x, &checker, 1);
}

SEXP c_qtest(SEXP x, SEXP rules, SEXP recursive, SEXP depth) {
    const R_len_t nrules = length(rules);

    if (!isString(rules))
        error("Argument 'rules' must be a string");
    if (nrules == 0)
        return ScalarLogical(TRUE);

    checker_t checker[nrules];
    SEXP tmp;
    for (R_len_t i = 0; i < nrules; i++) {
        tmp = STRING_ELT(rules, i);
        if (tmp == NA_STRING)
            error("Rule may not be NA");
        parse_rule(&checker[i], CHAR(STRING_ELT(rules, i)));
    }

    if (LOGICAL(recursive)[0])
        return ScalarLogical(qtest_list(x, checker, nrules, asCount(depth, "depth")));
    return ScalarLogical(qtest1(x, checker, nrules));
}
