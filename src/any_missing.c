#include "any_missing.h"
#include "check_missing.h"

Rboolean any_missing(SEXP x) {
    switch(TYPEOF(x)) {
        case LGLSXP: return any_missing_logical(x);
        case INTSXP: return any_missing_integer(x);
        case REALSXP: return any_missing_double(x);
        case CPLXSXP: return any_missing_complex(x);
        case STRSXP: return any_missing_string(x);
        case NILSXP: return FALSE;
        case VECSXP: return isFrame(x) ? any_missing_frame(x) : any_missing_list(x);
        case RAWSXP: return FALSE;
        default: error("Object of type '%s' not supported", type2char(TYPEOF(x)));
    }
}

SEXP c_any_missing(SEXP x) {
    return ScalarLogical(any_missing(x));
}
