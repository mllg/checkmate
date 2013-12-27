#ifndef IS_LEN_H
#define IS_LEN_H

#include "typedefs.h"

Rboolean is_len_eq(SEXP, const R_len_t);
Rboolean is_len_lt(SEXP, const R_len_t);
Rboolean is_len_le(SEXP, const R_len_t);
Rboolean is_len_gt(SEXP, const R_len_t);
Rboolean is_len_ge(SEXP, const R_len_t);

#endif
