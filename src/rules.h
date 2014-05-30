#ifndef CHECKMATE_RULES_H_
#define CHECKMATE_RULES_H_

#include <R.h>
#include <Rinternals.h>
#include "typedefs.h"
#include "cmessages.h"

void parse_rule(checker_t *, const char *);
msg_t check_rule(SEXP, const checker_t *, const Rboolean);

#endif
