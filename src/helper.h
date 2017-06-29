#ifndef CHECKMATE_HELPER_H_
#define CHECKMATE_HELPER_H_

#define USE_RINTERNALS
#include <R.h>
#include <Rinternals.h>
#include <R_ext/Visibility.h>

Rboolean attribute_hidden isStrictlyNumeric(SEXP);
Rboolean attribute_hidden isAtomicVector(SEXP);
Rboolean attribute_hidden isRList(SEXP);
R_len_t attribute_hidden get_ncols(SEXP);
R_len_t attribute_hidden get_nrows(SEXP);
double attribute_hidden asNumber(SEXP, const char *);
const char attribute_hidden * asString(SEXP, const char *);
R_xlen_t attribute_hidden asCount(SEXP, const char *);
Rboolean attribute_hidden asFlag(SEXP, const char *);

#endif
