#ifndef TYPEDEFS_H_
#define TYPEDEFS_H_

#include <R.h>
#include <Rinternals.h>

#define MSGLEN 255
#define CLASSLEN 15
#define OPLEN 3

/*  typedef enum { LT, LE, EQ, GE, GT, NONE } comp_t; */

typedef Rboolean(*dd_cmp)(double, double);

typedef struct {
    struct {
        Rboolean(*fun)(SEXP);
        char phony[CLASSLEN];
    } class;
    struct {
        Rboolean(*fun)(SEXP);
    } missing;
    struct {
        Rboolean(*fun)(R_len_t, R_len_t);
        R_len_t cmp;
        char phony[OPLEN];
    } len;
    struct {
        dd_cmp fun;
        double cmp;
        char phony[OPLEN];
    } lower;
    struct {
        dd_cmp fun;
        double cmp;
        char phony[OPLEN];
    } upper;
} checker_t;

typedef struct {
    Rboolean ok;
    char msg[MSGLEN];
} error_t;

#endif
