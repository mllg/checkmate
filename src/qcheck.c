#include "qcheck.h"
#include "parse_rule.h"
#include "check_rule.h"
#include "check_missing.h"

static inline Rboolean qcheck1(SEXP x, const checker_t *checker, const R_len_t nrules) {
    error_t result;
    for (R_len_t i = 0; i < nrules; i++) {
        result = check_rule(x, &checker[i], FALSE);
        if (result.ok)
            return TRUE;
    }
    return FALSE;
}

static inline Rboolean qcheck_list(SEXP x, const checker_t *checker, const R_len_t nrules) {
    if (!isNewList(x))
        error("Argument 'x' must be a list or data.frame");

    const R_len_t nx = length(x);
    for (R_len_t i = 0; i < nx; i++) {
        if (!qcheck1(VECTOR_ELT(x, i), checker, nrules))
            return FALSE;
    }
    return TRUE;
}

SEXP c_qcheck(SEXP x, SEXP rules, SEXP recursive) {
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
        parse_rule(&checker[i], CHAR(STRING_ELT(rules, i)), FALSE);
    }

    if (LOGICAL(recursive)[0])
        return ScalarLogical(qcheck_list(x, checker, nrules));
    return ScalarLogical(qcheck1(x, checker, nrules));
}
