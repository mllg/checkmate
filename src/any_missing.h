#ifndef CHECKMATE_ANY_MISSING_H_
#define CHECKMATE_ANY_MISSING_H_

#define USE_RINTERNALS
#include <R.h>
#include <Rinternals.h>

Rboolean any_missing_logical(SEXP);
Rboolean any_missing_integer(SEXP);
Rboolean any_missing_integerish(SEXP);
Rboolean any_missing_double(SEXP);
Rboolean any_missing_numeric(SEXP);
Rboolean any_missing_complex(SEXP);
Rboolean any_missing_string(SEXP);
Rboolean any_missing_atomic(SEXP);
Rboolean any_missing_list(SEXP);
Rboolean any_missing_matrix(SEXP);
Rboolean any_missing_frame(SEXP);
Rboolean any_missing(SEXP);
SEXP c_any_missing(SEXP);

#endif
