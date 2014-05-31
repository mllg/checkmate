#ifndef CHECKMATE_COMPS_H_
#define CHECKMATE_COMPS_H_

#include <R.h>
#include <Rinternals.h>

typedef Rboolean(*dd_cmp)(double, double);
typedef Rboolean(*ll_cmp)(R_len_t, R_len_t);

typedef enum { LT, LE, EQ, GE, GT, NE, NONE } cmp_t;
extern const char * CMPSTR[];

Rboolean ii_eq(const R_len_t x, const R_len_t y);
Rboolean ii_lt(const R_len_t x, const R_len_t y);
Rboolean ii_gt(const R_len_t x, const R_len_t y);
Rboolean ii_le(const R_len_t x, const R_len_t y);
Rboolean ii_ge(const R_len_t x, const R_len_t y);

Rboolean dd_eq(const double x, const double y);
Rboolean dd_lt(const double x, const double y);
Rboolean dd_gt(const double x, const double y);
Rboolean dd_le(const double x, const double y);
Rboolean dd_ge(const double x, const double y);
Rboolean dd_ne(const double x, const double y);

#endif
