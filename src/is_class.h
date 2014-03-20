#ifndef IS_CLASS_H_
#define IS_CLASS_H_

#include "typedefs.h"

Rboolean is_class_logical(SEXP);
Rboolean is_class_integer(SEXP);
Rboolean is_class_integerish(SEXP);
Rboolean is_class_double(SEXP);
Rboolean is_class_numeric(SEXP);
Rboolean is_class_complex(SEXP);
Rboolean is_class_string(SEXP);
Rboolean is_class_atomic(SEXP);
Rboolean is_class_list(SEXP);
Rboolean is_class_matrix(SEXP);
Rboolean is_class_frame(SEXP);
Rboolean is_class_function(SEXP);
Rboolean is_class_environment(SEXP);
Rboolean is_class_null(SEXP);
Rboolean is_class_factor(SEXP);

#endif
