#include "helper.h"
#include "any_missing.h"
#include "is_integerish.h"

const char * guessType(SEXP x) {
    SEXP attr = getAttrib(x, R_ClassSymbol);
    if (!isNull(attr))
        return CHAR(STRING_ELT(attr, 0));

    attr = getAttrib(x, R_DimSymbol);
    if (!isNull(attr) && isVectorAtomic(x))
        return length(attr) == 2 ? "matrix" : "array";

    return type2char(TYPEOF(x));
}

Rboolean isStrictlyNumeric(SEXP x) {
    switch(TYPEOF(x)) {
        case REALSXP: return TRUE;
        case INTSXP: return !inherits(x, "factor");
    }
    return FALSE;
}

/* Checks for a regular list, i.e. not a data frame, not NULL */
Rboolean isRList(SEXP x) {
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
R_len_t get_nrows(SEXP x) {
    if (!isVector(x) && !isList(x))
        error("Object does not have a dimension");

    if (isFrame(x))
        return length(getAttrib(x, R_RowNamesSymbol));
    SEXP dim = getAttrib(x, R_DimSymbol);
    return (dim == R_NilValue) ? length(x) : INTEGER(dim)[0];
}

R_len_t get_ncols(SEXP x) {
    if (!isVector(x) && !isList(x))
        error("Object does not have a dimension");

    if (isFrame(x))
        return length(x);
    SEXP dim = getAttrib(x, R_DimSymbol);
    return (length(dim) >= 2) ? INTEGER(dim)[1] : 1;
}


double asNumber(SEXP x, const char *vname) {
    if (!isNumeric(x) || xlength(x) != 1)
        error("Argument '%s' must be a number", vname);
    double xd = asReal(x);
    if (ISNAN(xd))
        error("Argument '%s' may not be missing", vname);
    return xd;
}

const char * asString(SEXP x, const char *vname) {
    if (!isString(x) || xlength(x) != 1)
        error("Argument '%s' must be a string", vname);
    if (any_missing_string(x))
        error("Argument '%s' may not be missing", vname);
    return CHAR(STRING_ELT(x, 0));
}

R_xlen_t asCount(SEXP x, const char *vname) {
    if (!isIntegerish(x, INTEGERISH_DEFAULT_TOL) || xlength(x) != 1)
        error("Argument '%s' must be a count", vname);
    int xi = asInteger(x);
    if (xi == NA_INTEGER)
        error("Argument '%s' may not be missing", vname);
    if (xi < 0)
        error("Argument '%s' must be >= 0", vname);
    return xi;
}

Rboolean asFlag(SEXP x, const char *vname) {
    if (!isLogical(x) || xlength(x) != 1)
        error("Argument '%s' must be a flag", vname);
    Rboolean xb = LOGICAL(x)[0];
    if (xb == NA_LOGICAL)
        error("Argument '%s' may not be missing", vname);
    return xb;
}
