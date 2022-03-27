#ifndef CHECKMATE_INTEGERISH_H_
#define CHECKMATE_INTEGERISH_H_

#include <R.h>
#include <Rinternals.h>
#include <R_ext/Visibility.h>
#include <float.h>

#define INTEGERISH_DEFAULT_TOL sqrt(DBL_EPSILON)
typedef enum { INT_OK, INT_TYPE, INT_RANGE, INT_TOL, INT_COMPLEX } cm_int_check_t;
typedef struct { R_xlen_t pos; cm_int_check_t err; } cm_int_err_t;

Rboolean isIntegerish(SEXP, double, Rboolean);
SEXP attribute_hidden c_is_integerish(SEXP, SEXP);
cm_int_err_t checkIntegerish(SEXP, const double, Rboolean);

#endif
