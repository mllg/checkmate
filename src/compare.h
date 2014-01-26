#ifndef COMPARE_H
#define COMPARE_H

#include "typedefs.h"

Rboolean ii_eq(const R_len_t, const R_len_t);
Rboolean ii_lt(const R_len_t, const R_len_t);
Rboolean ii_le(const R_len_t, const R_len_t);
Rboolean ii_gt(const R_len_t, const R_len_t);
Rboolean ii_ge(const R_len_t, const R_len_t);
Rboolean ii_ne(const R_len_t, const R_len_t);

Rboolean dd_eq(const double, const double);
Rboolean dd_lt(const double, const double);
Rboolean dd_le(const double, const double);
Rboolean dd_gt(const double, const double);
Rboolean dd_ge(const double, const double);
Rboolean dd_ne(const double, const double);

#endif
