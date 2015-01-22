#include "all_nchar.h"

Rboolean all_nchar(SEXP x, const R_len_t n) {
    const R_len_t nx = length(x);
    for (R_len_t i = 0; i < nx; i++) {
        if (STRING_ELT(x, i) == NA_STRING || length(STRING_ELT(x, i)) < n)
            return FALSE;
    }
    return TRUE;
}
