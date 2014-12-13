#include "helper.h"
Rboolean isStrictlyNumeric(SEXP x) {
    switch(TYPEOF(x)) {
        case REALSXP: return TRUE;
        case INTSXP: return !inherits(x, "factor");
    }
    return FALSE;
}


/* FIXME: I am unsure but there seems to be a bug in R C API
 * ncols(x) does not work for data.frames
 * so we now have our own little ncol / nrow wrappers....... :(
*/
R_len_t get_nrows(SEXP x) {
  if (isFrame(x))
    return length(x) == 0 ? 0 : length(VECTOR_ELT(x, 0));
  else
    return nrows(x);
}

R_len_t get_ncols(SEXP x) {
  if (isFrame(x))
    return length(x);
  else
    return ncols(x);
}
