#ifndef CHECKMATE_ANY_MISSING_H_
#define CHECKMATE_ANY_MISSING_H_

#define USE_RINTERNALS
#include <R.h>
#include <Rinternals.h>
#include <R_ext/Visibility.h>

Rboolean attribute_hidden any_missing_logical(SEXP);
Rboolean attribute_hidden any_missing_integer(SEXP);
Rboolean attribute_hidden any_missing_integerish(SEXP);
Rboolean attribute_hidden any_missing_double(SEXP);
Rboolean attribute_hidden any_missing_numeric(SEXP);
Rboolean attribute_hidden any_missing_complex(SEXP);
Rboolean attribute_hidden any_missing_string(SEXP);
Rboolean attribute_hidden any_missing_atomic(SEXP);
Rboolean attribute_hidden any_missing_list(SEXP);
Rboolean attribute_hidden any_missing_matrix(SEXP);
Rboolean attribute_hidden any_missing_frame(SEXP);
Rboolean any_missing(SEXP);
SEXP attribute_hidden c_any_missing(SEXP);

#endif
