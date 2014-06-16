#ifndef CHECKMATE_RULES_H_
#define CHECKMATE_RULES_H_

#include <R.h>
#include <Rinternals.h>
#include "cmessages.h"
#include "comps.h"
#include "bounds.h"

typedef enum {
    CL_LOGICAL, CL_INTEGER, CL_INTEGERISH, CL_NUMERIC, CL_DOUBLE, CL_STRING, CL_LIST, CL_COMPLEX,
    CL_ATOMIC, CL_ATOMIC_VECTOR, CL_MATRIX, CL_DATAFRAME, CL_ENVIRONMENT, CL_FUNCTION, CL_NULL, CL_NONE
} class_t;

typedef struct {
    struct {
        Rboolean(*fun)(SEXP);
        class_t name;
    } class;
    struct {
        Rboolean(*fun)(SEXP);
    } missing;
    struct {
        ll_cmp fun;
        R_len_t cmp;
        cmp_t op;
    } len;
    bound_t lower;
    bound_t upper;
} checker_t;

void parse_rule(checker_t *, const char *);
msg_t check_rule(SEXP, const checker_t *, const Rboolean);

#endif
