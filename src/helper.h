#ifndef CHECKMATE_HELPER_H_
#define CHECKMATE_HELPER_H_

#include <R.h>
#include <Rinternals.h>

Rboolean isStrictlyNumeric(SEXP);
R_len_t get_ncols(SEXP);
R_len_t get_nrows(SEXP);

#endif
