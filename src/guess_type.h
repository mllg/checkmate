#ifndef CHECKMATE_GUESS_TYPE_H_
#define CHECKMATE_GUESS_TYPE_H_

#include <R.h>
#include <Rinternals.h>
#include <R_ext/Visibility.h>

const char * guess_type(SEXP);
SEXP attribute_hidden c_guess_type(SEXP);

#endif
