#ifndef CHECKMATE_ANY_MISSING_H_
#define CHECKMATE_ANY_MISSING_H_

#define USE_RINTERNALS
#include <R.h>
#include <Rinternals.h>
#include <R_ext/Visibility.h>
#include <Rversion.h>

R_xlen_t attribute_hidden find_missing_logical(SEXP);
R_xlen_t attribute_hidden find_missing_integer(SEXP);
R_xlen_t attribute_hidden find_missing_integerish(SEXP);
R_xlen_t attribute_hidden find_missing_double(SEXP);
R_xlen_t attribute_hidden find_missing_numeric(SEXP);
R_xlen_t attribute_hidden find_missing_complex(SEXP);
R_xlen_t attribute_hidden find_missing_string(SEXP);
R_xlen_t attribute_hidden find_missing_atomic(SEXP);
R_xlen_t attribute_hidden find_missing_list(SEXP);
Rboolean attribute_hidden any_missing_matrix(SEXP);
Rboolean attribute_hidden any_missing_frame(SEXP);
Rboolean any_missing(SEXP);
SEXP attribute_hidden c_any_missing(SEXP);

#endif
