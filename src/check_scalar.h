#ifndef CHECKMATE_CHECK_SCALAR_H_
#define CHECKMATE_CHECK_SCALAR_H_

#include <R.h>
#include <Rinternals.h>

SEXP c_check_flag(SEXP, SEXP);
SEXP c_check_count(SEXP, SEXP);
SEXP c_check_number(SEXP, SEXP);
SEXP c_check_string(SEXP, SEXP);

#endif
