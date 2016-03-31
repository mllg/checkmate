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
