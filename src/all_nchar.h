#ifndef CHECKMATE_ALL_NCHAR_H_
#define CHECKMATE_ALL_NCHAR_H_

#define USE_RINTERNALS
#include <R.h>
#include <Rinternals.h>

Rboolean all_nchar(SEXP, R_xlen_t, Rboolean);

#endif
