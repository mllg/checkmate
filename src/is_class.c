#include "is_class.h"

inline Rboolean is_class_logical(SEXP x) {
    return isLogical(x);
}
inline Rboolean is_class_integer(SEXP x) {
    return isInteger(x);
}
inline Rboolean is_class_double(SEXP x) {
    return isReal(x);
}
inline Rboolean is_class_numeric(SEXP x) {
    return isInteger(x) || isReal(x);
}
inline Rboolean is_class_complex(SEXP x) {
    return isComplex(x);
}
inline Rboolean is_class_string(SEXP x) {
    return isString(x);
}
inline Rboolean is_class_atomic(SEXP x) {
    return isVectorAtomic(x);
}
inline Rboolean is_class_list(SEXP x) {
    return isNewList(x) && !isFrame(x);
}
inline Rboolean is_class_matrix(SEXP x) {
    return isMatrix(x);
}
inline Rboolean is_class_frame(SEXP x) {
    return isFrame(x);
}
inline Rboolean is_class_function(SEXP x) {
    return isFunction(x);
}
inline Rboolean is_class_environment(SEXP x) {
    return isEnvironment(x);
}
inline Rboolean is_class_null(SEXP x) {
    return isNull(x);
}
inline Rboolean is_class_factor(SEXP x) {
    return isFactor(x);
}
