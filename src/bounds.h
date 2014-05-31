#ifndef CHECKMATE_BOUNDS_H_
#define CHECKMATE_BOUNDS_H_

#include <R.h>
#include <Rinternals.h>
#include "cmessages.h"
#include "comps.h"

typedef struct { dd_cmp fun; double cmp; cmp_t op; } bound_t;

msg_t check_bound(SEXP, bound_t);
msg_t check_bounds(SEXP, SEXP, SEXP);

#endif
