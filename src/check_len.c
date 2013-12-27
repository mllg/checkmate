#include "check_len.h"

inline Rboolean check_len_eq(SEXP x, const R_len_t n) {
    return length(x) == n;
}
inline Rboolean check_len_lt(SEXP x, const R_len_t n) {
    return length(x) < n;
}
inline Rboolean check_len_gt(SEXP x, const R_len_t n) {
    return length(x) > n;
}
inline Rboolean check_len_le(SEXP x, const R_len_t n) {
    return length(x) <= n;
}
inline Rboolean check_len_ge(SEXP x, const R_len_t n) {
    return length(x) >= n;
}
