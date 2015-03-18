#include "cmessages.h"

const msg_t MSGT = { .ok = TRUE };
const msg_t MSGF = { .ok = FALSE };

msg_t make_msg(const char *fmt, ...) {
    msg_t msg = { .ok = FALSE };
    va_list vargs;
    va_start(vargs, fmt);
    vsnprintf(msg.msg, CMSGLEN, fmt, vargs);
    va_end(vargs);
    return msg;
}

SEXP make_result(const char *fmt, ...) {
    char msg[CMSGLEN];
    va_list vargs;
    va_start(vargs, fmt);
    vsnprintf(msg, CMSGLEN, fmt, vargs);
    va_end(vargs);
    return ScalarString(mkChar(msg));
}

SEXP mwrap(msg_t msg) {
    if (msg.ok)
        return ScalarLogical(TRUE);
    return ScalarString(mkChar(msg.msg));
}
