#include "assertions.h"
#include "is_integerish.h"

void assertFlag(SEXP x, const char *vname) {
    if (!isLogical(x) || length(x) != 1)
        error("Argument '%s' must be a flag", vname);
}

void assertCount(SEXP x, const char *vname) {
    if (!isIntegerish(x, INTEGERISH_DEFAULT_TOL) || length(x) != 1)
        error("Argument '%s' must be a count", vname);
    if (asInteger(x) < 0)
        error("Argument '%s' must be > 0", vname);
}

void assertNumber(SEXP x, const char *vname) {
    if (!isNumeric(x) || length(x) != 1)
        error("Argument '%s' must be a number", vname);
}
