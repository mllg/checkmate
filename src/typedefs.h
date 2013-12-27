#ifndef TYPEDEFS_H_
#define TYPEDEFS_H_

#include <R.h>
#include <Rinternals.h>

#define MSGLEN 255
#define PHONYLEN 15

typedef struct {
    Rboolean(*class)(SEXP);
    Rboolean(*missing)(SEXP);
    Rboolean(*len)(SEXP, R_len_t);
    R_len_t cmp;
    char phony_class[PHONYLEN];
    char phony_len[PHONYLEN];
} checker_t;

typedef struct {
    Rboolean ok;
    char msg[MSGLEN];
} error_t;

#endif
