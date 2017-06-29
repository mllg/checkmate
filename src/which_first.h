#ifndef CHECKMATE_WHICH_FIRST_H_
#define CHECKMATE_WHICH_FIRST_H_

#define USE_RINTERNALS
#include <R.h>
#include <Rinternals.h>
#include <R_ext/Visibility.h>

SEXP c_which_first(SEXP, SEXP);
SEXP c_which_last(SEXP, SEXP);

#endif
