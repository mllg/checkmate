#include "check_class.h"

inline Rboolean check_class_logical(SEXP x) {
    return isLogical(x);
}
inline Rboolean check_class_integer(SEXP x) {
    return isInteger(x);
}
inline Rboolean check_class_double(SEXP x) {
    return isReal(x);
}
inline Rboolean check_class_numeric(SEXP x) {
    return isInteger(x) || isReal(x);
}
inline Rboolean check_class_complex(SEXP x) {
    return isComplex(x);
}
inline Rboolean check_class_string(SEXP x) {
    return isString(x);
}
inline Rboolean check_class_atomic(SEXP x) {
    return isVectorAtomic(x);
}
inline Rboolean check_class_list(SEXP x) {
    return isNewList(x) && !isFrame(x);
}
inline Rboolean check_class_matrix(SEXP x) {
    return isMatrix(x);
}
inline Rboolean check_class_frame(SEXP x) {
    return isFrame(x);
}
inline Rboolean check_class_function(SEXP x) {
    return isFunction(x);
}
inline Rboolean check_class_environment(SEXP x) {
    return isEnvironment(x);
}
inline Rboolean check_class_null(SEXP x) {
    return isNull(x);
}
