#ifndef CHECK_LEN_H_
#define CHECK_LEN_H_

#include "typedefs.h"

Rboolean check_len_eq(SEXP, const R_len_t);
Rboolean check_len_lt(SEXP, const R_len_t);
Rboolean check_len_le(SEXP, const R_len_t);
Rboolean check_len_gt(SEXP, const R_len_t);
Rboolean check_len_ge(SEXP, const R_len_t);

#endif
