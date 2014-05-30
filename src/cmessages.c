#include "cmessages.h"

const msg_t MSGT = { .ok = TRUE };
const msg_t MSGF = { .ok = FALSE };

msg_t newMsg(const char * str) {
    msg_t msg = MSGF;
    strncpy(msg.msg, str, CMSGLEN);
    return msg;
}

msg_t newMsgf(const char *fmt, ...) {
    msg_t msg = MSGF;
    va_list vargs;
    va_start(vargs, fmt);
    vsnprintf(msg.msg, CMSGLEN, fmt, vargs);
    return msg;
}

void setMsg(msg_t *msg, const char * str) {
    strncpy(msg->msg, str, CMSGLEN);
    msg->ok = FALSE;
}

void setMsgf(msg_t *msg, const char *fmt, ...) {
    va_list vargs;
    va_start(vargs, fmt);
    vsnprintf(msg->msg, CMSGLEN, fmt, vargs);
    msg->ok = FALSE;
}

SEXP mwrap(msg_t msg) {
    if (msg.ok)
        return ScalarLogical(TRUE);
    return ScalarString(mkChar(msg.msg));
}
