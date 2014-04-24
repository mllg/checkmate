#ifndef IS_INTEGERISH_H_
#define IS_INTEGERISH_H_

#include <R.h>
#include <Rinternals.h>
#include <math.h>
#define DEFAULT_TOL DOUBLE_EPS

Rboolean is_integerish(SEXP, double);
SEXP c_is_integerish(SEXP, SEXP);

#endif
