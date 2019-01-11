#include <math.h>
#include "helper.h"
#include "any_missing.h"
#include "integerish.h"
#include "guess_type.h"
#include "backports.h"


R_len_t translate_row(R_len_t pos, R_len_t nrow) {
    return (pos - 1) % nrow;
}

R_len_t translate_col(R_len_t pos, R_len_t nrow) {
    return (R_len_t)((pos - 1) / nrow);
}

/* ncols and nrows is bugged for data frames:
 * (a) data.frames are treated like lists and thus you get length() back
 * (b) reports wrong dimension for zero-column data frames
 * Here are our own wrappers
 * */
R_len_t attribute_hidden get_nrows(SEXP x) {
    if (isFrame(x)) {
        if (inherits(x, "data.table")) {
            /* c.f. https://github.com/Rdatatable/data.table/issues/3149 */
            return (length(x) == 0) ? 0 : length(VECTOR_ELT(x, 0));
        } else {
            return length(getAttrib(x, R_RowNamesSymbol));
        }
    }
    SEXP dim = getAttrib(x, R_DimSymbol);
    return (dim == R_NilValue) ? length(x) : INTEGER_RO(dim)[0];
}

R_len_t attribute_hidden get_ncols(SEXP x) {
    if (isFrame(x))
        return length(x);
    SEXP dim = getAttrib(x, R_DimSymbol);
    return (length(dim) >= 2) ? INTEGER_RO(dim)[1] : 1;
}


double attribute_hidden asNumber(SEXP x, const char *vname) {
    if (!isNumeric(x))
        error("Argument '%s' must be a number, but is %s", vname, guess_type(x));
    if (xlength(x) != 1)
        error("Argument '%s' must have length 1, but has length %i", vname, xlength(x));
    double xd = asReal(x);
    if (ISNAN(xd))
        error("Argument '%s' may not be missing", vname);
    return xd;
}

const char attribute_hidden * asString(SEXP x, const char *vname) {
    if (!isString(x) || xlength(x) != 1)
        error("Argument '%s' must be a string, but is %s", vname, guess_type(x));
    if (find_missing_string(x) > 0)
        error("Argument '%s' may not be missing", vname);
    return CHAR(STRING_ELT(x, 0));
}

R_len_t attribute_hidden asCount(SEXP x, const char *vname) {
    if (length(x) != 1)
        error("Argument '%x' must have length 1", vname);
    if (!isIntegerish(x, INTEGERISH_DEFAULT_TOL, FALSE))
        error("Argument '%s' must be numeric and close to an integer", vname);
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
            int xi = INTEGER_RO(x)[0];
            if (xi == NA_INTEGER)
                error("Argument '%s' may not be missing", vname);
            if (xi < 0)
                error("Argument '%s' must be >= 0", vname);
            return (R_xlen_t) xi;
        case REALSXP:;
            double xr = REAL_RO(x)[0];
            if (xr == NA_REAL)
                error("Argument '%s' may not be missing", vname);
            if (xr < 0)
                error("Argument '%s' must be >= 0", vname);
            if (fabs(xr - nearbyint(xr)) >= INTEGERISH_DEFAULT_TOL)
                error("Argument '%s' is not close to an integer", vname);
            return (R_xlen_t) xr;
    }
    error("Argument '%s' must be a length, but is %s", vname, guess_type(x));
}

Rboolean attribute_hidden asFlag(SEXP x, const char *vname) {
    if (!isLogical(x) || xlength(x) != 1)
        error("Argument '%s' must be a flag, but is %s", vname, guess_type(x));
    Rboolean xb = LOGICAL_RO(x)[0];
    if (xb == NA_LOGICAL)
        error("Argument '%s' may not be missing", vname);
    return xb;
}


Rboolean is_class_logical(SEXP x) { return isLogical(x); }
Rboolean is_class_integer(SEXP x) { return isInteger(x); }
Rboolean is_class_integerish(SEXP x) { return isIntegerish(x, INTEGERISH_DEFAULT_TOL, TRUE); }
Rboolean is_class_numeric(SEXP x) {
    switch(TYPEOF(x)) {
        case REALSXP: return TRUE;
        case INTSXP: return !inherits(x, "factor");
    }
    return FALSE;
}
Rboolean is_class_double(SEXP x) { return isReal(x); }
Rboolean is_class_complex(SEXP x) { return isComplex(x); }
Rboolean is_class_string(SEXP x) { return isString(x); }
Rboolean is_class_factor(SEXP x) { return isFactor(x); }
Rboolean is_class_atomic(SEXP x) { return isNull(x) || isVectorAtomic(x); }
Rboolean is_class_atomic_vector(SEXP x) {
    if (!isVectorAtomic(x))
        return FALSE;
    return isNull(getAttrib(x, R_DimSymbol));
}
Rboolean is_class_list(SEXP x) {
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

Rboolean is_class_matrix(SEXP x) { return isMatrix(x); }
Rboolean is_class_array(SEXP x) { return isArray(x); }
Rboolean is_class_frame(SEXP x) { return isFrame(x); }
Rboolean is_class_environment(SEXP x) { return isEnvironment(x); }
Rboolean is_class_null(SEXP x) { return isNull(x); }
Rboolean is_class_posixct(SEXP x) { return isReal(x) && inherits(x, "POSIXct"); }
Rboolean is_class_raw(SEXP x) { return TYPEOF(x) == RAWSXP; }
