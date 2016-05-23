#include "guessType.h"

const char * guessType(SEXP x) {
    SEXP attr = getAttrib(x, R_ClassSymbol);
    if (!isNull(attr))
        return CHAR(STRING_ELT(attr, 0));

    attr = getAttrib(x, R_DimSymbol);
    if (!isNull(attr) && isVectorAtomic(x))
        return length(attr) == 2 ? "matrix" : "array";

    return type2char(TYPEOF(x));
}

SEXP c_guessType(SEXP x) {
    return ScalarString(mkChar(guessType(x)));
}
