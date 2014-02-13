#include <limits.h>
#include <string.h>
#include "parse_rule.h"
#include "is_class.h"
#include "any_missing.h"
#include "compare.h"

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
        case 'e':
            checker->class.fun = &is_class_environment;
            checker->class.name = CL_ENVIRONMENT;
            break;
        case 'f':
            checker->class.fun = &is_class_function;
            checker->class.name = CL_FUNCTION;
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
    checker->lower.fun = NULL;
    checker->upper.fun = NULL;

    switch(rule[0]) {
        case '\0':
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
    double cmp;
    const char *start = rule+1;

    cmp = strtod(start, &end);
    if (*end != ',') {
        error("Invalid bound definition, error parsing lower bound or missing separator ',': %s", rule);
    }
    if (start == end) {
        if (checker->lower.op == GT) {
            checker->lower.fun = &dd_ne;
            checker->lower.cmp = R_NegInf;
        } else {
            checker->lower.fun = NULL;
        }
    } else {
        checker->lower.cmp = cmp;
    }

    start = end + 1;
    cmp = strtod(start, &end);

    if (*end == ')') {
        checker->upper.op = LT;
        if (start == end) {
            checker->upper.fun = &dd_ne;
            checker->upper.cmp = R_PosInf;
        } else {
            checker->upper.fun = &dd_lt;
            checker->upper.cmp = cmp;
        }
    } else if (*end == ']') {
        if (start == end) {
            checker->upper.fun = NULL;
        } else {
            checker->upper.fun = &dd_le;
            checker->upper.cmp = cmp;
        }
    } else {
        error("Invalid bound definition, error parsing upper bound or missing closing ')'/']': %s", rule);
    }

    return end-rule+1;
}

void parse_rule(checker_t *checker, const char *rule) {
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
