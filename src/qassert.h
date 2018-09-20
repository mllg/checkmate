#ifndef CHECKMATE_QASSERT_H_
#define CHECKMATE_QASSERT_H_

#include <R.h>
#include <Rinternals.h>
#include <R_ext/Visibility.h>

SEXP attribute_hidden c_qassert(SEXP, SEXP, SEXP);
SEXP attribute_hidden c_qtest(SEXP, SEXP, SEXP, SEXP);
SEXP qassert(SEXP, const char *, const char *);
Rboolean qtest(SEXP, const char *);

#endif
