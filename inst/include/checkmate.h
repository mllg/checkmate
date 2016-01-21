#include <R.h>
#include <R_ext/Rdynload.h>
#include <Rinternals.h>
#include <Rdefines.h>

#ifndef _CHECKMATE
#define _CHECKMATE

#ifdef __cplusplus
extern "C" {
#endif

Rboolean qtest(SEXP x, const char *rule) {
  static Rboolean(*fun)(SEXP, const char *) = NULL;
  if (fun == NULL)
    fun = (Rboolean(*)(SEXP, const char *)) R_GetCCallable("checkmate", "qtest");
  return fun(x, rule);
}

Rboolean qassert(SEXP x, const char *rule, const char *name) {
  static Rboolean(*fun)(SEXP, const char *, const char *) = NULL;
  if (fun == NULL)
    fun = (Rboolean(*)(SEXP, const char *, const char *)) R_GetCCallable("checkmate", "qassert");
  return fun(x, rule, name);
}

#endif /* _CHECKMATE */

#ifdef __cplusplus
}
#endif
