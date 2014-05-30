#include "capitalize.h"
#include <ctype.h>
#include <string.h>

SEXP c_capitalize(SEXP x) {
    if (!isString(x))
        error("Argument 'x' must be a string");

    const R_len_t n = length(x);
    SEXP res = PROTECT(allocVector(STRSXP, n));

    for (R_len_t i = 0; i < n; i++) {
        char *tmp = malloc (strlen(CHAR(STRING_ELT(x, i))) + 1);
        if (tmp == NULL)
            error("Error allocating memory");
        strcpy(tmp, translateChar(STRING_ELT(x, i)));
        tmp[0] = toupper(tmp[0]);
        SET_STRING_ELT(res, i, mkChar(tmp));
        free(tmp);
    }

    UNPROTECT(1);
    return res;
}