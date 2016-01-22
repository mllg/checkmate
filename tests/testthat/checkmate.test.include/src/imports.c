#include <R.h>
#include <R_ext/Rdynload.h>
#include <checkmate.h>

SEXP c_reexported_qtest(SEXP x, SEXP rule) {
    return ScalarLogical(qtest(x, CHAR(STRING_ELT(rule, 0))));
}

SEXP c_reexported_qassert(SEXP x, SEXP rule, SEXP varname) {
    return qassert(x, CHAR(STRING_ELT(rule, 0)), CHAR(STRING_ELT(rule, 0)));
}
