#ifndef CHECKMATE_GUESS_TYPE_H_
#define CHECKMATE_GUESS_TYPE_H_

#define USE_RINTERNALS
#include <R.h>
#include <Rinternals.h>

const char * guess_type(SEXP);
SEXP c_guess_type(SEXP);

#endif
