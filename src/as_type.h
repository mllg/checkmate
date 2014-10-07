#ifndef CHECKMATE_ASSERTIONS_H_
#define CHECKMATE_ASSERTIONS_H_

#include <R.h>
#include <Rinternals.h>

double asNumber(SEXP, const char *);
const char * asString(SEXP, const char *);
R_len_t asCount(SEXP, const char *);
Rboolean asFlag(SEXP, const char *);

#endif
