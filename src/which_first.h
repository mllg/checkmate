#ifndef CHECKMATE_WHICH_FIRST_H_
#define CHECKMATE_WHICH_FIRST_H_

#include <R.h>
#define USE_RINTERNALS
#include <Rinternals.h>
#include <Rdefines.h>

SEXP c_which_first(SEXP);
SEXP c_which_last(SEXP);

#endif
