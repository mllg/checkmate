#ifndef CHECKMATE_ANY_MISSING_H_
#define CHECKMATE_ANY_MISSING_H_

#include <R.h>
#define USE_RINTERNALS
#include <Rinternals.h>

typedef enum {
    MISS_NONE = 0, MISS_LOGICAL, MISS_INTEGER, MISS_DOUBLE, MISS_COMPLEX,
    MISS_CHARACTER, MISS_LIST
} miss_t;

miss_t any_missing_logical(SEXP);
miss_t any_missing_integer(SEXP);
miss_t any_missing_integerish(SEXP);
miss_t any_missing_double(SEXP);
miss_t any_missing_numeric(SEXP);
miss_t any_missing_complex(SEXP);
miss_t any_missing_string(SEXP);
miss_t any_missing_atomic(SEXP);
miss_t any_missing_list(SEXP);
miss_t any_missing_matrix(SEXP);
miss_t any_missing_frame(SEXP);
SEXP c_any_missing(SEXP);

#endif
