#ifndef CHECKMATE_BOUNDS_H_
#define CHECKMATE_BOUNDS_H_

#include <R.h>
#include <Rinternals.h>
#include "cmessages.h"

typedef Rboolean(*dd_cmp)(double, double);
typedef enum { LT, LE, EQ, GE, GT, NE, NONE } cmp_t;
typedef struct { dd_cmp fun; double cmp; cmp_t op; } bound_t;

Rboolean dd_eq(const double x, const double y);
Rboolean dd_lt(const double x, const double y);
Rboolean dd_gt(const double x, const double y);
Rboolean dd_le(const double x, const double y);
Rboolean dd_ge(const double x, const double y);
Rboolean dd_ne(const double x, const double y);

Rboolean is_in_bound(SEXP, const bound_t);
const char* getOperatorString(const cmp_t);
msg_t check_bounds(SEXP, SEXP, SEXP);

#endif