#include "cmessages.h"

const msg_t MSGT = { .ok = TRUE };
const msg_t MSGF = { .ok = FALSE };

msg_t Msg(const char *str) {
    msg_t msg = MSGF;
    strncpy(msg.msg, str, CMSGLEN);
    return msg;
}

msg_t Msgf(const char *fmt, ...) {
    msg_t msg = MSGF;
    va_list vargs;
    va_start(vargs, fmt);
    vsnprintf(msg.msg, CMSGLEN, fmt, vargs);
    va_end(vargs);
    return msg;
}

SEXP CheckResult(const char *str) {
    return ScalarString(mkChar(str));
}

SEXP CheckResultf(const char *fmt, ...) {
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
