#ifndef CHECKMATE_CHECKS_H_
#define CHECKMATE_CHECKS_H_

#include <R.h>
#include <Rinternals.h>
#include <R_ext/Visibility.h>

SEXP attribute_hidden c_check_array(SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP);
SEXP attribute_hidden c_check_atomic(SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP);
SEXP attribute_hidden c_check_atomic_vector(SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP);
SEXP attribute_hidden c_check_character(SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP);
SEXP attribute_hidden c_check_complex(SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP);
SEXP attribute_hidden c_check_dataframe(SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP);
SEXP attribute_hidden c_check_factor(SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP);
SEXP attribute_hidden c_check_integer(SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP);
SEXP attribute_hidden c_check_integerish(SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP);
SEXP attribute_hidden c_check_list(SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP);
SEXP attribute_hidden c_check_logical(SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP);
SEXP attribute_hidden c_check_matrix(SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP);
SEXP attribute_hidden c_check_named(SEXP, SEXP);
SEXP attribute_hidden c_check_names(SEXP, SEXP);
SEXP attribute_hidden c_check_numeric(SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP);
SEXP attribute_hidden c_check_vector(SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP);

SEXP attribute_hidden c_check_count(SEXP, SEXP, SEXP, SEXP, SEXP);
SEXP attribute_hidden c_check_flag(SEXP, SEXP, SEXP);
SEXP attribute_hidden c_check_int(SEXP, SEXP, SEXP, SEXP, SEXP, SEXP);
SEXP attribute_hidden c_check_number(SEXP, SEXP, SEXP, SEXP, SEXP, SEXP);
SEXP attribute_hidden c_check_scalar(SEXP, SEXP, SEXP);
SEXP attribute_hidden c_check_string(SEXP, SEXP, SEXP, SEXP);

#endif
