#ifndef CHECKMATE_QASSERT_H_
#define CHECKMATE_QASSERT_H_

#include <R.h>
#define USE_RINTERNALS
#include <Rinternals.h>

SEXP c_qassert(SEXP, SEXP, SEXP);
SEXP c_qtest(SEXP, SEXP, SEXP);
SEXP qassert(SEXP, const char *, const char *);
Rboolean qtest(SEXP, const char *);

#endif
