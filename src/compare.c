#include "compare.h"

inline Rboolean ii_eq(const R_len_t x, const R_len_t y) { return x == y; }
inline Rboolean ii_lt(const R_len_t x, const R_len_t y) { return x < y; }
inline Rboolean ii_gt(const R_len_t x, const R_len_t y) { return x > y; }
inline Rboolean ii_le(const R_len_t x, const R_len_t y) { return x <= y; }
inline Rboolean ii_ge(const R_len_t x, const R_len_t y) { return x >= y; }

inline Rboolean dd_lt(const double x, const double y) { return x < y; }
inline Rboolean dd_gt(const double x, const double y) { return x > y; }
inline Rboolean dd_le(const double x, const double y) { return x <= y; }
inline Rboolean dd_ge(const double x, const double y) { return x >= y; }
inline Rboolean dd_neq(const double x, const double y) { return x != y; }
