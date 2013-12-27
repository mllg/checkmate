#ifndef CHECK_CLASS_H_
#define CHECK_CLASS_H_

#include "typedefs.h"

Rboolean check_class_logical(SEXP);
Rboolean check_class_integer(SEXP);
Rboolean check_class_double(SEXP);
Rboolean check_class_numeric(SEXP);
Rboolean check_class_complex(SEXP);
Rboolean check_class_string(SEXP);
Rboolean check_class_atomic(SEXP);
Rboolean check_class_list(SEXP);
Rboolean check_class_matrix(SEXP);
Rboolean check_class_frame(SEXP);
Rboolean check_class_function(SEXP);
Rboolean check_class_environment(SEXP);
Rboolean check_class_null(SEXP);

#endif
