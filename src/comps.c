#include "comps.h"


Rboolean ii_eq(const R_len_t x, const R_len_t y) { return x == y; }
Rboolean ii_lt(const R_len_t x, const R_len_t y) { return x <  y; }
Rboolean ii_gt(const R_len_t x, const R_len_t y) { return x >  y; }
Rboolean ii_le(const R_len_t x, const R_len_t y) { return x <= y; }
Rboolean ii_ge(const R_len_t x, const R_len_t y) { return x >= y; }

Rboolean dd_eq(const double x, const double y) { return x == y; }
Rboolean dd_lt(const double x, const double y) { return x <  y; }
Rboolean dd_gt(const double x, const double y) { return x >  y; }
Rboolean dd_le(const double x, const double y) { return x <= y; }
Rboolean dd_ge(const double x, const double y) { return x >= y; }
Rboolean dd_ne(const double x, const double y) { return x != y; }

const char * CMPSTR[] = { "<", "<=", "==", ">=", ">", "!=" };
