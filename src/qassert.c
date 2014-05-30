#include "qassert.h"
#include "rules.h"
#include "any_missing.h"
#include "cmessages.h"

static inline R_len_t qassert1(SEXP x, const checker_t *checker, msg_t *result, const R_len_t nrules) {
    for (R_len_t i = 0; i < nrules; i++) {
        result[i] = check_rule(x, &checker[i], result[i].ok);
        if (result[i].ok)
            return 0;
    }
    return 1;
}

static inline R_len_t qassert_list(SEXP x, const checker_t *checker, msg_t *result, const R_len_t nrules) {
    if (!isNewList(x))
        error("Argument 'x' must be a list or data.frame");

    const R_len_t nx = length(x);
    for (R_len_t i = 0; i < nx; i++) {
        if (qassert1(VECTOR_ELT(x, i), checker, result, nrules) != 0)
            return i + 1;
    }
    return 0;
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
