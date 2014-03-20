#ifndef IS_INTEGERISH_H_
#define IS_INTEGERISH_H_

#include "typedefs.h"
#include <math.h>
#define DEFAULT_TOL DOUBLE_EPS

Rboolean isIntegerish(SEXP, double);
SEXP c_is_integerish(SEXP, SEXP);

#endif
