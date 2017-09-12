#include <math.h>
#include "helper.h"
#include "any_missing.h"
#include "is_integerish.h"

Rboolean attribute_hidden isStrictlyNumeric(SEXP x) {
    switch(TYPEOF(x)) {
        case REALSXP: return TRUE;
        case INTSXP: return !inherits(x, "factor");
    }
    return FALSE;
}

Rboolean attribute_hidden isAtomicVector(SEXP x) {
    if (!isVectorAtomic(x))
        return FALSE;
    return isNull(getAttrib(x, R_DimSymbol));
}

/* Checks for a regular list, i.e. not a data frame, not NULL */
Rboolean attribute_hidden isRList(SEXP x) {
    if (TYPEOF(x) == VECSXP) {
        SEXP cl = getAttrib(x, R_ClassSymbol);
        const R_len_t n = length(cl);
        for (R_len_t i = 0; i < n; i++) {
            if (strcmp(CHAR(STRING_ELT(cl, i)), "data.frame") == 0)
                return FALSE;
        }
        return TRUE;
    }
    return FALSE;
}

/* ncols and nrows is bugged for data frames:
 * (a) data.frames are treated like lists and thus you get length() back
 * (b) reports wrong dimension for zero-column data frames
 * Here are our own wrappers
 * */
R_len_t attribute_hidden get_nrows(SEXP x) {
    if (isFrame(x))
        return length(getAttrib(x, R_RowNamesSymbol));
    SEXP dim = getAttrib(x, R_DimSymbol);
    return (dim == R_NilValue) ? length(x) : INTEGER(dim)[0];
}

R_len_t attribute_hidden get_ncols(SEXP x) {
    if (isFrame(x))
        return length(x);
    SEXP dim = getAttrib(x, R_DimSymbol);
    return (length(dim) >= 2) ? INTEGER(dim)[1] : 1;
}


double attribute_hidden asNumber(SEXP x, const char *vname) {
    if (!isNumeric(x) || xlength(x) != 1)
        error("Argument '%s' must be a number", vname);
    double xd = asReal(x);
    if (ISNAN(xd))
        error("Argument '%s' may not be missing", vname);
    return xd;
}

const char attribute_hidden * asString(SEXP x, const char *vname) {
    if (!isString(x) || xlength(x) != 1)
        error("Argument '%s' must be a string", vname);
    if (any_missing_string(x))
        error("Argument '%s' may not be missing", vname);
    return CHAR(STRING_ELT(x, 0));
}

R_len_t attribute_hidden asCount(SEXP x, const char *vname) {
    if (length(x) != 1)
        error("Argument '%x' must have length 1", vname);
    if (!isIntegerish(x, INTEGERISH_DEFAULT_TOL, FALSE))
        error("Argument '%s' must be close to an integer", vname);
    int xi = asInteger(x);
    if (xi == NA_INTEGER)
        error("Argument '%s' may not be missing", vname);
    if (xi < 0)
        error("Argument '%s' must be >= 0", vname);
    return xi;
}

R_xlen_t attribute_hidden asLength(SEXP x, const char *vname) {
    if (length(x) != 1)
        error("Argument '%x' must have length 1", vname);
    switch(TYPEOF(x)) {
        case INTSXP:;
            int xi = INTEGER(x)[0];
            if (xi == NA_INTEGER)
                error("Argument '%s' may not be missing", vname);
            if (xi < 0)
                error("Argument '%s' must be >= 0", vname);
            return (R_xlen_t) xi;
        case REALSXP:;
            double xr = REAL(x)[0];
            if (xr == NA_REAL)
                error("Argument '%s' may not be missing", vname);
            if (xr < 0)
                error("Argument '%s' must be >= 0", vname);
            if (fabs(xr - nearbyint(xr)) >= INTEGERISH_DEFAULT_TOL)
                error("Argument '%s' is not close to an integer", vname);
            return (R_xlen_t) xr;
    }
    error("Argument '%s' must be a length", vname);
}

Rboolean attribute_hidden asFlag(SEXP x, const char *vname) {
    if (!isLogical(x) || xlength(x) != 1)
        error("Argument '%s' must be a flag", vname);
    Rboolean xb = LOGICAL(x)[0];
    if (xb == NA_LOGICAL)
        error("Argument '%s' may not be missing", vname);
    return xb;
}
