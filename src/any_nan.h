#ifndef CHECKMATE_ANY_NAN_H_
#define CHECKMATE_ANY_NAN_H_

#include <R.h>
#define USE_RINTERNALS
#include <Rinternals.h>

SEXP c_any_nan(SEXP);
Rboolean any_nan(SEXP);

#endif
