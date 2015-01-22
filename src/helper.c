#include "helper.h"
#include "any_missing.h"
#include "is_integerish.h"

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


double asNumber(SEXP x, const char *vname) {
    if (!isNumeric(x) || length(x) != 1)
        error("Argument '%s' must be a number", vname);
    double xd = asReal(x);
    if (ISNAN(xd))
        error("Argument '%s' may not be missing", vname);
    return xd;
}

const char * asString(SEXP x, const char *vname) {
    if (!isString(x) || length(x) != 1)
        error("Argument '%s' must be a string", vname);
    if (any_missing_string(x))
        error("Argument '%s' may not be missing", vname);
    return CHAR(STRING_ELT(x, 0));
}

R_len_t asCount(SEXP x, const char *vname) {
    if (!isIntegerish(x, INTEGERISH_DEFAULT_TOL) || length(x) != 1)
        error("Argument '%s' must be a count", vname);
    int xi = asInteger(x);
    if (xi == NA_INTEGER)
        error("Argument '%s' may not be missing", vname);
    if (xi < 0)
        error("Argument '%s' must be >= 0", vname);
    return xi;
}

Rboolean asFlag(SEXP x, const char *vname) {
    if (!isLogical(x) || length(x) != 1)
        error("Argument '%s' must be a flag", vname);
    Rboolean xb = LOGICAL(x)[0];
    if (xb == NA_LOGICAL)
        error("Argument '%s' may not be missing", vname);
    return xb;
}
