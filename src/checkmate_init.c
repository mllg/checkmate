#include "qassert.h"
#include <R_ext/Rdynload.h>

void R_init_checkmate(DllInfo *info) {
  R_RegisterCCallable("checkmate", "qtest",  (DL_FUNC) &qtest);
  R_RegisterCCallable("checkmate", "qassert",  (DL_FUNC) &qassert);
}

