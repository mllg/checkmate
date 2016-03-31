#ifndef CHECKMATE_HELPER_H_
#define CHECKMATE_HELPER_H_

#define USE_RINTERNALS
#include <R.h>
#include <Rinternals.h>

const char * guessType(SEXP);
Rboolean isStrictlyNumeric(SEXP);
Rboolean isRList(SEXP);
R_len_t get_ncols(SEXP);
R_len_t get_nrows(SEXP);
double asNumber(SEXP, const char *);
const char * asString(SEXP, const char *);
R_xlen_t asCount(SEXP, const char *);
Rboolean asFlag(SEXP, const char *);

#endif
