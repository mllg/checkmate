#ifndef CHECKMATE_IS_INTEGERISH_H_
#define CHECKMATE_IS_INTEGERISH_H_

#define USE_RINTERNALS
#include <R.h>
#include <Rinternals.h>
#include <R_ext/Visibility.h>

#define INTEGERISH_DEFAULT_TOL sqrt(DOUBLE_EPS)
Rboolean isIntegerish(SEXP, double, Rboolean);
SEXP attribute_hidden c_is_integerish(SEXP, SEXP);

#endif
