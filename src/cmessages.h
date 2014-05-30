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
msg_t newMsg(const char *);
msg_t newMsgf(const char *, ...);
void setMsgf(msg_t *, const char *, ...);
void setMsg(msg_t *, const char *);
SEXP mwrap(msg_t);

#endif
