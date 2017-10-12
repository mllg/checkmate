#include <R.h>
#include <Rinternals.h>
#include <stdlib.h> // for NULL
#include <R_ext/Rdynload.h>
#include "qassert.h"

/* .Call calls */
extern SEXP c_all_missing(SEXP);
extern SEXP c_any_infinite(SEXP);
extern SEXP c_any_missing(SEXP);
extern SEXP c_any_nan(SEXP);
extern SEXP c_check_array(SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP);
extern SEXP c_check_atomic(SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP);
extern SEXP c_check_atomic_vector(SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP);
extern SEXP c_check_character(SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP);
extern SEXP c_check_complex(SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP);
extern SEXP c_check_count(SEXP, SEXP, SEXP, SEXP, SEXP);
extern SEXP c_check_dataframe(SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP);
extern SEXP c_check_factor(SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP);
extern SEXP c_check_flag(SEXP, SEXP, SEXP);
extern SEXP c_check_int(SEXP, SEXP, SEXP, SEXP, SEXP, SEXP);
extern SEXP c_check_integer(SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP);
extern SEXP c_check_integerish(SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP);
extern SEXP c_check_list(SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP);
extern SEXP c_check_logical(SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP);
extern SEXP c_check_matrix(SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP);
extern SEXP c_check_named(SEXP, SEXP);
extern SEXP c_check_names(SEXP, SEXP);
extern SEXP c_check_number(SEXP, SEXP, SEXP, SEXP, SEXP, SEXP);
extern SEXP c_check_numeric(SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP);
extern SEXP c_check_scalar(SEXP, SEXP, SEXP);
extern SEXP c_check_string(SEXP, SEXP, SEXP, SEXP);
extern SEXP c_check_vector(SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP);
extern SEXP c_check_posixct(SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP);
extern SEXP c_guess_type(SEXP);
extern SEXP c_is_integerish(SEXP, SEXP);
extern SEXP c_qassert(SEXP, SEXP, SEXP);
extern SEXP c_qtest(SEXP, SEXP, SEXP, SEXP);
extern SEXP c_which_first(SEXP, SEXP);
extern SEXP c_which_last(SEXP, SEXP);

static const R_CallMethodDef CallEntries[] = {
    {"c_all_missing",         (DL_FUNC) &c_all_missing,          1},
    {"c_any_infinite",        (DL_FUNC) &c_any_infinite,         1},
    {"c_any_missing",         (DL_FUNC) &c_any_missing,          1},
    {"c_any_nan",             (DL_FUNC) &c_any_nan,              1},
    {"c_check_array",         (DL_FUNC) &c_check_array,          7},
    {"c_check_atomic",        (DL_FUNC) &c_check_atomic,         8},
    {"c_check_atomic_vector", (DL_FUNC) &c_check_atomic_vector,  8},
    {"c_check_character",     (DL_FUNC) &c_check_character,     10},
    {"c_check_complex",       (DL_FUNC) &c_check_complex,        9},
    {"c_check_count",         (DL_FUNC) &c_check_count,          5},
    {"c_check_dataframe",     (DL_FUNC) &c_check_dataframe,     10},
    {"c_check_factor",        (DL_FUNC) &c_check_factor,         9},
    {"c_check_flag",          (DL_FUNC) &c_check_flag,           3},
    {"c_check_int",           (DL_FUNC) &c_check_int,            6},
    {"c_check_integer",       (DL_FUNC) &c_check_integer,       12},
    {"c_check_integerish",    (DL_FUNC) &c_check_integerish,    13},
    {"c_check_list",          (DL_FUNC) &c_check_list,           9},
    {"c_check_logical",       (DL_FUNC) &c_check_logical,        9},
    {"c_check_matrix",        (DL_FUNC) &c_check_matrix,        11},
    {"c_check_named",         (DL_FUNC) &c_check_named,          2},
    {"c_check_names",         (DL_FUNC) &c_check_names,          2},
    {"c_check_number",        (DL_FUNC) &c_check_number,         6},
    {"c_check_numeric",       (DL_FUNC) &c_check_numeric,       13},
    {"c_check_scalar",        (DL_FUNC) &c_check_scalar,         3},
    {"c_check_string",        (DL_FUNC) &c_check_string,         4},
    {"c_check_vector",        (DL_FUNC) &c_check_vector,        10},
    {"c_check_posixct",       (DL_FUNC) &c_check_posixct,       11},
    {"c_guess_type",          (DL_FUNC) &c_guess_type,           1},
    {"c_is_integerish",       (DL_FUNC) &c_is_integerish,        2},
    {"c_qassert",             (DL_FUNC) &c_qassert,              3},
    {"c_qtest",               (DL_FUNC) &c_qtest,                4},
    {"c_which_first",         (DL_FUNC) &c_which_first,          2},
    {"c_which_last",          (DL_FUNC) &c_which_last,           2},
    {NULL, NULL, 0}
};

void R_init_checkmate(DllInfo *dll) {
    R_registerRoutines(dll, NULL, CallEntries, NULL, NULL);
    R_useDynamicSymbols(dll, FALSE);
    R_RegisterCCallable("checkmate", "qtest",  (DL_FUNC) &qtest);
    R_RegisterCCallable("checkmate", "qassert",  (DL_FUNC) &qassert);
}
