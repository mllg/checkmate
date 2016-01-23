#ifndef CHECKMATE_ANY_INFINITE_H_
#define CHECKMATE_ANY_INFINITE_H_

#define USE_RINTERNALS
#include <R.h>
#include <Rinternals.h>

SEXP c_any_infinite(SEXP);
Rboolean any_infinite(SEXP);

#endif
