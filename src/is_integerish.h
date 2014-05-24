#ifndef CHECKMATE_IS_INTEGERISH_H_
#define CHECKMATE_IS_INTEGERISH_H_

#include <R.h>
#include <Rinternals.h>

Rboolean is_integerish(SEXP, double);
SEXP c_is_integerish(SEXP, SEXP);

#endif
