#ifndef CHECKMATE_GUESSTYPE_H_
#define CHECKMATE_GUESSTYPE_H_

#define USE_RINTERNALS
#include <R.h>
#include <Rinternals.h>

const char * guessType(SEXP);
SEXP c_guessType(SEXP);

#endif
