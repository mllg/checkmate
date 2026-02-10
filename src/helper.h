#ifndef CHECKMATE_HELPER_H_
#define CHECKMATE_HELPER_H_

#include <R.h>
#include <Rinternals.h>
#include <R_ext/Visibility.h>

R_len_t translate_row(R_len_t, R_len_t);
R_len_t translate_col(R_len_t, R_len_t);
R_len_t attribute_hidden get_ncols(SEXP);
R_len_t attribute_hidden get_nrows(SEXP);
double attribute_hidden as_number(SEXP, const char *);
const char attribute_hidden * as_string(SEXP, const char *);
R_len_t attribute_hidden as_count(SEXP, const char *);
R_xlen_t attribute_hidden as_length(SEXP, const char *);
Rboolean attribute_hidden as_flag(SEXP, const char *);

Rboolean is_class_logical(SEXP x);
Rboolean is_class_integer(SEXP x);
Rboolean is_class_integerish(SEXP x);
Rboolean is_class_double(SEXP x);
Rboolean is_class_numeric(SEXP x);
Rboolean is_class_complex(SEXP x);
Rboolean is_class_string(SEXP x);
Rboolean is_class_factor(SEXP x);
Rboolean is_class_atomic(SEXP x);
Rboolean is_class_atomic_vector(SEXP x);
Rboolean is_class_list(SEXP x);
Rboolean is_class_matrix(SEXP x);
Rboolean is_class_array(SEXP x);
Rboolean is_class_frame(SEXP x);
Rboolean is_class_environment(SEXP x);
Rboolean is_class_null(SEXP x);
Rboolean is_class_posixct(SEXP x);
Rboolean is_class_raw(SEXP x);
Rboolean has_attributes(SEXP x);

#endif
