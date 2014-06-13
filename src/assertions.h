#ifndef CHECKMATE_ASSERTIONS_H_
#define CHECKMATE_ASSERTIONS_H_

#include <R.h>
#include <Rinternals.h>

void assertFlag(SEXP, const char *);
void assertCount(SEXP, const char *);
void assertNumber(SEXP, const char *);
void assertString(SEXP, const char *);

#endif
