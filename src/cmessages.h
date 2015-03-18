#ifndef CHECKMATE_CMESSAGES_H_
#define CHECKMATE_CMESSAGES_H_

#include <R.h>
#include <Rinternals.h>

enum { CMSGLEN = 256 };
typedef struct {
    Rboolean ok;
    char msg[CMSGLEN];
} msg_t;

extern const msg_t MSGT;
extern const msg_t MSGF;
msg_t make_msg(const char *, ...);
SEXP make_result(const char *, ...);
const char * guessType(SEXP);
SEXP make_type_error(SEXP, const char *);
SEXP mwrap(msg_t);

#endif
