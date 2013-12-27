#include <limits.h>
#include <string.h>
#include "parse_rule.h"
#include "is_class.h"
#include "any_missing.h"
#include "is_len.h"

void parse_rule(checker_t *checker, const char *rule, const Rboolean phony) {
    const R_len_t nchars = strlen(rule);
    if (nchars == 0)
        error("Empty rule");
    checker->missing = NULL;

    switch(rule[0]) {
        case 'B':
            checker->missing = &any_missing_logical;
        case 'b':
            checker->class = &is_class_logical;
            if (phony)
                strncpy(checker->phony_class, "logical", PHONYLEN);
            break;
        case 'I':
            checker->missing = &any_missing_integer;
        case 'i':
            checker->class = &is_class_integer;
            if (phony)
                strncpy(checker->phony_class, "integer", PHONYLEN);
            break;
        case 'N':
            checker->missing = &any_missing_numeric;
        case 'n':
            checker->class = &is_class_numeric;
            if (phony)
                strncpy(checker->phony_class, "numeric", PHONYLEN);
            break;
        case 'R':
            checker->missing = &any_missing_double;
        case 'r':
            checker->class = &is_class_double;
            if (phony)
                strncpy(checker->phony_class, "double", PHONYLEN);
            break;
        case 'S':
            checker->missing = &any_missing_string;
        case 's':
            checker->class = &is_class_string;
            if (phony)
                strncpy(checker->phony_class, "string", PHONYLEN);
            break;
        case 'L':
            checker->missing = &any_missing_list;
        case 'l':
            checker->class = &is_class_list;
            if (phony)
                strncpy(checker->phony_class, "list", PHONYLEN);
            break;
        case 'C':
            checker->missing = &any_missing_complex;
        case 'c':
            checker->class = &is_class_complex;
            if (phony)
                strncpy(checker->phony_class, "complex", PHONYLEN);
            break;
        case 'A':
            checker->missing = &any_missing_atomic;
        case 'a':
            checker->class = &is_class_atomic;
            if (phony)
                strncpy(checker->phony_class, "atomic", PHONYLEN);
            break;
        case 'M':
            checker->missing = &any_missing_matrix;
        case 'm':
            checker->class = &is_class_matrix;
            if (phony)
                strncpy(checker->phony_class, "matrix", PHONYLEN);
            break;
        case 'D':
            checker->missing = &any_missing_frame;
        case 'd':
            checker->class = &is_class_frame;
            if (phony)
                strncpy(checker->phony_class, "data.frame", PHONYLEN);
            break;
        case 'e':
            checker->class = &is_class_environment;
            if (phony)
                strncpy(checker->phony_class, "environment", PHONYLEN);
            break;
        case 'f':
            checker->class = &is_class_function;
            if (phony)
                strncpy(checker->phony_class, "environment", PHONYLEN);
            break;
        case '0':
            checker->class = &is_class_null;
            if (phony)
                strncpy(checker->phony_class, "NULL", PHONYLEN);
            break;
        case '*':
            checker->class = NULL;
            break;
        default:
            error("Unknown class identifier '%c'", rule[0]);
            break;
    }

    if (nchars == 1) {
        checker->len = NULL;
        return;
    }

    R_len_t pos = 1;
    switch(rule[1]) {
        case '*':
            if (nchars > 2)
                error("Invalid length definition: %s", rule+1);
            checker->len = NULL;
            return;
        case '?':
            if (nchars > 2)
                error("Invalid length definition: %s", rule+1);
            checker->len = &is_len_le;
            checker->cmp = 1;
            if (phony)
                strncpy(checker->phony_len, "<=", PHONYLEN);
            return;
        case '+':
            if (nchars > 2)
                error("Invalid length definition: %s", rule+1);
            checker->len = &is_len_ge;
            checker->cmp = 1;
            if (phony)
                strncpy(checker->phony_len, ">=", PHONYLEN);
            return;
        case '=':
            if (nchars < 3)
                error("Invalid length definition: %s", rule+1);
            checker->len = &is_len_eq;
            if (phony)
                strncpy(checker->phony_len, "<", PHONYLEN);
            pos += 1 + (rule[2] == '=');
            break;
        case '<':
            if (nchars < 3)
                error("Invalid length definition: %s", rule+1);
            if (rule[2] == '=') {
                checker->len = &is_len_le;
                if (phony)
                    strncpy(checker->phony_len, "<", PHONYLEN);
                pos += 2;
            } else {
                checker->len = &is_len_lt;
                if (phony)
                    strncpy(checker->phony_len, "<=", PHONYLEN);
                pos += 1;
            }
            break;
        case '>':
            if (nchars < 3)
                error("Invalid length definition: %s", rule+1);
            if (rule[2] == '=') {
                checker->len = &is_len_ge;
                if (phony)
                    strncpy(checker->phony_len, ">", PHONYLEN);
                pos += 2;
            } else {
                checker->len = &is_len_gt;
                if (phony)
                    strncpy(checker->phony_len, ">=", PHONYLEN);
                pos += 1;
            }
            break;
        default:
            checker->len = &is_len_eq;
            if (phony)
                strncpy(checker->phony_len, "==", PHONYLEN);
            break;
    }

    char *end;
    long int cmp = strtol(rule+pos, &end, 10);
    if (*end || *end == rule[pos])
        error("Invalid length definition: %s", rule+1);
    if (cmp >= INT_MAX)
        error("Cannot handle length > %i", INT_MAX);
    if (cmp < 0)
        error("Cannot check for negative length");
    checker->cmp = (int)cmp;
}
