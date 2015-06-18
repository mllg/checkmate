#ifndef CHECKMATE_ANY_INFINITE_H_
#define CHECKMATE_ANY_INFINITE_H_

#include <R.h>
#define USE_RINTERNALS
#include <Rinternals.h>

SEXP c_any_infinite(SEXP);
Rboolean any_infinite(SEXP);

#endif
