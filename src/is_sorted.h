#ifndef CHECKMATE_IS_SORTED_H_
#define CHECKMATE_IS_SORTED_H_

#define USE_RINTERNALS
#include <R.h>
#include <Rinternals.h>
#include <R_ext/Visibility.h>
#include <Rversion.h>

Rboolean isSorted(SEXP x);

#endif
