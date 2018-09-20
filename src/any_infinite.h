#ifndef CHECKMATE_ANY_INFINITE_H_
#define CHECKMATE_ANY_INFINITE_H_

#include <R.h>
#include <Rinternals.h>
#include <R_ext/Visibility.h>

Rboolean any_infinite(SEXP);
SEXP attribute_hidden c_any_infinite(SEXP);

#endif
