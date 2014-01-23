#ifndef TYPEDEFS_H_
#define TYPEDEFS_H_

#include <R.h>
#include <Rinternals.h>

#define MSGLEN 255
#define PHONYLEN 15

//typedef Rboolean(*compfun)(double, double);

typedef struct {
    struct {
        Rboolean(*fun)(SEXP);
        char phony[PHONYLEN];
    } class;
    struct {
        Rboolean(*fun)(SEXP);
    } missing;
    struct {
        Rboolean(*fun)(R_len_t, R_len_t);
        R_len_t cmp;
        char phony[PHONYLEN];
    } len;
    struct {
        Rboolean(*fun)(double, double);
        double cmp;
    } lower;
    struct {
        Rboolean(*fun)(double, double);
        double cmp;
    } upper;
} checker_t;

typedef struct {
    Rboolean ok;
    char msg[MSGLEN];
} error_t;

#endif
