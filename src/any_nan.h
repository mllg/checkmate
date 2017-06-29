#ifndef CHECKMATE_ANY_NAN_H_
#define CHECKMATE_ANY_NAN_H_

#define USE_RINTERNALS
#include <R.h>
#include <Rinternals.h>
#include <R_ext/Visibility.h>

Rboolean any_nan(SEXP);
SEXP attribute_hidden c_any_nan(SEXP);

#endif
