#ifndef TYPEDEFS_H_
#define TYPEDEFS_H_

#include <R.h>
#include <Rinternals.h>

#define MSGLEN 255

typedef Rboolean(*ll_cmp)(R_len_t, R_len_t);
typedef Rboolean(*dd_cmp)(double, double);
typedef enum { LT, LE, EQ, GE, GT, NONE } comp_t;
typedef enum { CL_LOGICAL, CL_INTEGER, CL_INTEGERISH, CL_NUMERIC, CL_DOUBLE, CL_STRING,
    CL_LIST, CL_COMPLEX, CL_ATOMIC, CL_MATRIX, CL_DATAFRAME,
    CL_ENVIRONMENT, CL_FUNCTION, CL_NULL, CL_NONE } class_t;
typedef struct { dd_cmp fun; double cmp; comp_t op; } bound_t;

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
        comp_t op;
    } len;
    bound_t lower;
    bound_t upper;
} checker_t;

typedef struct {
    Rboolean ok;
    char msg[MSGLEN];
} error_t;

#endif
