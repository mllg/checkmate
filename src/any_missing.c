#include "any_missing.h"
#include "backports.h"

R_xlen_t attribute_hidden find_missing_logical(SEXP x) {
    const R_xlen_t n = xlength(x);
    const int * xp = LOGICAL_RO(x);
    for (R_xlen_t i = 0; i < n; i++) {
        if (xp[i] == NA_LOGICAL)
            return i + 1;
    }
    return 0;
}

R_xlen_t attribute_hidden find_missing_integer(SEXP x) {
#if defined(R_VERSION) && R_VERSION >= R_Version(3, 5, 0)
    if (INTEGER_NO_NA(x))
        return 0;
#endif
    const R_xlen_t n = xlength(x);
    const int * xp = INTEGER_RO(x);
    for (R_xlen_t i = 0; i < n; i++) {
        if (xp[i] == NA_INTEGER)
            return i + 1;
    }
    return 0;
}

R_xlen_t attribute_hidden find_missing_integerish(SEXP x) {
    switch(TYPEOF(x)) {
        case LGLSXP: return find_missing_logical(x);
        case INTSXP: return find_missing_integer(x);
        case REALSXP: return find_missing_double(x);
        default: error("Error in find_missing_integerish: x must be logical or numeric");
    }
}

R_xlen_t attribute_hidden find_missing_double(SEXP x) {
#if defined(R_VERSION) && R_VERSION >= R_Version(3, 5, 0)
    if (REAL_NO_NA(x))
        return 0;
#endif
    const R_xlen_t n = xlength(x);
    const double * xp = REAL_RO(x);
    for (R_xlen_t i = 0; i < n; i++) {
        if (ISNAN(xp[i]))
            return i + 1;
    }
    return 0;
}

R_xlen_t attribute_hidden find_missing_numeric(SEXP x) {
    switch(TYPEOF(x)) {
        case INTSXP: return find_missing_integer(x);
        case REALSXP: return find_missing_double(x);
        default: error("Error in find_missing_numeric: x must be integer or double");
    }
}

R_xlen_t attribute_hidden find_missing_complex(SEXP x) {
    const R_xlen_t n = xlength(x);
    const Rcomplex * xp = COMPLEX_RO(x);
    for (R_xlen_t i = 0; i < n; i++) {
        if (ISNAN((xp[i]).r) || ISNAN((xp[i]).i))
            return i + 1;
    }
    return 0;
}

R_xlen_t attribute_hidden find_missing_string(SEXP x) {
#if defined(R_VERSION) && R_VERSION >= R_Version(3, 5, 0)
    if (STRING_NO_NA(x))
        return 0;
#endif
    const R_xlen_t nx = xlength(x);
    for (R_xlen_t i = 0; i < nx; i++) {
        if (STRING_ELT(x, i) == NA_STRING)
            return i + 1;
    }
    return 0;
}

R_xlen_t attribute_hidden find_missing_list(SEXP x) {
    const R_xlen_t n = xlength(x);
    for (R_xlen_t i = 0; i < n; i++) {
        if (isNull(VECTOR_ELT(x, i)))
            return i + 1;
    }
    return 0;
}

R_xlen_t attribute_hidden find_missing_vector(SEXP x) {
    switch(TYPEOF(x)) {
        case LGLSXP:  return find_missing_logical(x);
        case INTSXP:  return find_missing_integer(x);
        case REALSXP: return find_missing_double(x);
        case CPLXSXP: return find_missing_complex(x);
        case STRSXP:  return find_missing_string(x);
        case VECSXP:  return find_missing_list(x);
        default:      return 0;
    }
}

R_xlen_t attribute_hidden find_missing_matrix(SEXP x) {
    return find_missing_vector(x);
}

R_xlen_t attribute_hidden find_missing_frame(SEXP x) {
    const R_xlen_t nc = xlength(x);
    for (R_xlen_t j = 0; j < nc; j++) {
        SEXP xj = VECTOR_ELT(x, j);
        if (TYPEOF(xj) != VECSXP) {
            R_xlen_t i = find_missing_vector(xj);
            if (i > 0) {
                return (j * length(xj)) + i;
            }
        }
    }
    return 0;
}

Rboolean any_missing(SEXP x) {
    switch(TYPEOF(x)) {
        case LGLSXP:  return find_missing_logical(x) > 0;
        case INTSXP:  return find_missing_integer(x) > 0;
        case REALSXP: return find_missing_double(x) > 0;
        case CPLXSXP: return find_missing_complex(x) > 0;
        case STRSXP:  return find_missing_string(x) > 0;
        case NILSXP:  return FALSE;
        case VECSXP:  if (isFrame(x)) {
                        return find_missing_frame(x) > 0;
                      } else {
                          return find_missing_list(x) > 0;
                      }
        case RAWSXP:  return FALSE;
        default: error("Object of type '%s' not supported", type2char(TYPEOF(x)));
    }
}

SEXP attribute_hidden c_any_missing(SEXP x) {
    return ScalarLogical(any_missing(x));
}
