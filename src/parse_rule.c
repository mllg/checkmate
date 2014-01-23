#include <limits.h>
#include <float.h>
#include <string.h>
#include "parse_rule.h"
#include "is_class.h"
#include "any_missing.h"
#include "compare.h"

static int parse_class(checker_t *checker, const char *rule, const Rboolean phony) {
    checker->missing.fun = NULL;
    switch(rule[0]) {
        case 'B':
            checker->missing.fun = &any_missing_logical;
        case 'b':
            checker->class.fun = &is_class_logical;
            if (phony)
                strncpy(checker->class.phony, "logical", PHONYLEN);
            break;
        case 'I':
            checker->missing.fun = &any_missing_integer;
        case 'i':
            checker->class.fun = &is_class_integer;
            if (phony)
                strncpy(checker->class.phony, "integer", PHONYLEN);
            break;
        case 'N':
            checker->missing.fun = &any_missing_numeric;
        case 'n':
            checker->class.fun = &is_class_numeric;
            if (phony)
                strncpy(checker->class.phony, "numeric", PHONYLEN);
            break;
        case 'R':
            checker->missing.fun = &any_missing_double;
        case 'r':
            checker->class.fun = &is_class_double;
            if (phony)
                strncpy(checker->class.phony, "double", PHONYLEN);
            break;
        case 'S':
            checker->missing.fun = &any_missing_string;
        case 's':
            checker->class.fun = &is_class_string;
            if (phony)
                strncpy(checker->class.phony, "string", PHONYLEN);
            break;
        case 'L':
            checker->missing.fun = &any_missing_list;
        case 'l':
            checker->class.fun = &is_class_list;
            if (phony)
                strncpy(checker->class.phony, "list", PHONYLEN);
            break;
        case 'C':
            checker->missing.fun = &any_missing_complex;
        case 'c':
            checker->class.fun = &is_class_complex;
            if (phony)
                strncpy(checker->class.phony, "complex", PHONYLEN);
            break;
        case 'A':
            checker->missing.fun = &any_missing_atomic;
        case 'a':
            checker->class.fun = &is_class_atomic;
            if (phony)
                strncpy(checker->class.phony, "atomic", PHONYLEN);
            break;
        case 'M':
            checker->missing.fun = &any_missing_matrix;
        case 'm':
            checker->class.fun = &is_class_matrix;
            if (phony)
                strncpy(checker->class.phony, "matrix", PHONYLEN);
            break;
        case 'D':
            checker->missing.fun = &any_missing_frame;
        case 'd':
            checker->class.fun = &is_class_frame;
            if (phony)
                strncpy(checker->class.phony, "data.frame", PHONYLEN);
            break;
        case 'e':
            checker->class.fun = &is_class_environment;
            if (phony)
                strncpy(checker->class.phony, "environment", PHONYLEN);
            break;
        case 'f':
            checker->class.fun = &is_class_function;
            if (phony)
                strncpy(checker->class.phony, "environment", PHONYLEN);
            break;
        case '0':
            checker->class.fun = &is_class_null;
            if (phony)
                strncpy(checker->class.phony, "NULL", PHONYLEN);
            break;
        case '*':
            checker->class.fun = NULL;
            break;
        default:
            error("Unknown class identifier '%c'", rule[0]);
    }
    return 1;
}

static int parse_length(checker_t *checker, const char *rule, const Rboolean phony) {
    switch(rule[0]) {
        case '*':
            checker->len.fun = NULL;
            return 1;
        case '?':
            checker->len.fun= &ii_le;
            checker->len.cmp = 1;
            if (phony)
                strncpy(checker->len.phony, "<=", PHONYLEN);
            return 1;
        case '+':
            checker->len.fun = &ii_ge;
            checker->len.cmp = 1;
            if (phony)
                strncpy(checker->len.phony, ">=", PHONYLEN);
            return 1;
        case '(':
        case '[':
        case '\0':
            checker->len.fun = NULL;
            return 0;
    }

    const char *start = rule;
    switch(rule[0]) {
        case '=':
            checker->len.fun = &ii_eq;
            if (phony)
                strncpy(checker->len.phony, "<", PHONYLEN);
            start += 1 + (rule[1] == '=');
            break;
        case '<':
            if (rule[1] == '=') {
                checker->len.fun = &ii_le;
                if (phony)
                    strncpy(checker->len.phony, "<", PHONYLEN);
                start += 2;
            } else {
                checker->len.fun = &ii_lt;
                if (phony)
                    strncpy(checker->len.phony, "<=", PHONYLEN);
                start += 1;
            }
            break;
        case '>':
            if (rule[1] == '=') {
                checker->len.fun = &ii_ge;
                if (phony)
                    strncpy(checker->len.phony, ">", PHONYLEN);
                start += 2;
            } else {
                checker->len.fun = &ii_gt;
                if (phony)
                    strncpy(checker->len.phony, ">=", PHONYLEN);
                start += 1;
            }
            break;
        default:
            checker->len.fun = &ii_eq;
            if (phony)
                strncpy(checker->len.phony, "==", PHONYLEN);
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

static int parse_bounds(checker_t *checker, const char *rule, const Rboolean phony) {
    switch(rule[0]) {
        case '\0':
            return 0;
        case '(':
            checker->lower.fun = &dd_gt;
            break;
        case '[':
            checker->lower.fun = &dd_gt;
            break;
        default:
            error("Invalid bound definition, must opening '(' or '[': %s", rule);
    }

    char *end;
    double cmp;
    const char *start = rule+1;

    cmp = strtod(start, &end);
    if (start == end) {
        checker->lower.fun = NULL;
    } else {
        if (*end != ',') {
            error("Invalid bound definition, missing separating ',': %s", rule);
        }
        checker->lower.cmp = cmp;
    }

    start = end+1;
    cmp = strtod(start, &end);
    if (start == end) {
        checker->upper.fun = NULL;
    } else {
        if (*end == ')') {
            checker->upper.fun = &dd_lt;
        } else if (*end == ']') {
            checker->upper.fun = &dd_le;
        } else {
            error("Invalid bound definition, missing closing ')' or ']': %s", rule);
        }
        checker->upper.cmp = cmp;
    }
    return rule - end;
}

void parse_rule(checker_t *checker, const char *rule, const Rboolean phony) {
    const R_len_t nchars = strlen(rule);
    if (nchars == 0)
        error("Empty rule");

    checker->class.fun = NULL;
    checker->len.fun = NULL;
    checker->missing.fun = NULL;

    //checker.lower = DBL_MIN;
    //checker.upper = DBL_MAX;

    rule += parse_class(checker, rule, phony);
    rule += parse_length(checker, rule, phony);
    rule += parse_bounds(checker, rule, phony);
    if (rule[0] == '\0')
        return;
    error("Additional chars found!");
}
