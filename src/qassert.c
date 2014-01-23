#include "qassert.h"
#include "parse_rule.h"
#include "check_rule.h"
#include "any_missing.h"

static inline Rboolean qassert1(SEXP x, const checker_t *checker, error_t *result, const R_len_t nrules) {
    for (R_len_t i = 0; i < nrules; i++) {
        result[i] = check_rule(x, &checker[i], result[i].ok);
        if (result[i].ok)
            return TRUE;
    }
    return FALSE;
}

static inline Rboolean qassert_list(SEXP x, const checker_t *checker, error_t *result, const R_len_t nrules) {
    if (!isNewList(x))
        error("Argument 'x' must be a list or data.frame");

    const R_len_t nx = length(x);
    for (R_len_t i = 0; i < nx; i++) {
        if (!qassert1(VECTOR_ELT(x, i), checker, result, nrules))
            return FALSE;
    }
    return TRUE;
}

SEXP c_qassert(SEXP x, SEXP rules, SEXP recursive) {
    const Rboolean nrules = length(rules);
    if (!isString(rules))
        error("Argument 'rules' must be a string");
    if (nrules == 0)
        return ScalarLogical(TRUE);

    error_t result[nrules];
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
        if (qassert_list(x, checker, result, nrules))
            return ScalarLogical(TRUE);
    } else {
        if (qassert1(x, checker, result, nrules))
            return ScalarLogical(TRUE);
    }

    SEXP msgs = PROTECT(allocVector(STRSXP, nrules));
    for (R_len_t i = 0; i < nrules; i++)
        SET_STRING_ELT(msgs, i, mkChar(result[i].msg));
    UNPROTECT(1);
    return msgs;
}
