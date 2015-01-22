#ifndef CHECKMATE_QASSERT_H_
#define CHECKMATE_QASSERT_H_

#include <R.h>
#include <Rinternals.h>

SEXP c_qassert(SEXP, SEXP, SEXP);
SEXP c_qtest(SEXP, SEXP, SEXP);

#endif
