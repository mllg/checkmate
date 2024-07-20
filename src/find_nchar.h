#ifndef CHECKMATE_FIND_NCHAR_H_
#define CHECKMATE_FIND_NCHAR_H_

#include <R.h>
#include <Rinternals.h>

R_xlen_t find_nchar(SEXP, R_xlen_t);
R_xlen_t find_min_nchar(SEXP, R_xlen_t);
R_xlen_t find_max_nchar(SEXP, R_xlen_t);

#endif
