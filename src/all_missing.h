#ifndef CHECKMATE_ALL_MISSING_H_
#define CHECKMATE_ALL_MISSING_H_

#include <R.h>
#include <Rinternals.h>

Rboolean all_missing_logical(SEXP);
Rboolean all_missing_integer(SEXP);
Rboolean all_missing_integerish(SEXP);
Rboolean all_missing_double(SEXP);
Rboolean all_missing_numeric(SEXP);
Rboolean all_missing_complex(SEXP);
Rboolean all_missing_string(SEXP);
Rboolean all_missing_atomic(SEXP);
Rboolean all_missing_list(SEXP);
Rboolean all_missing_matrix(SEXP);
Rboolean all_missing_frame(SEXP);
SEXP c_all_missing(SEXP);

#endif
