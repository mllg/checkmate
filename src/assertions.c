#include "assertions.h"
#include "is_integerish.h"
#include "any_missing.h"

void assertFlag(SEXP x, const char *vname) {
    if (!isLogical(x) || length(x) != 1)
        error("Argument '%s' must be a flag", vname);
    if (any_missing_logical(x))
        error("Argument '%s' may not be missing", vname);
}

void assertCount(SEXP x, const char *vname) {
    if (!isIntegerish(x, INTEGERISH_DEFAULT_TOL) || length(x) != 1)
        error("Argument '%s' must be a count", vname);
    if (any_missing_integerish(x))
        error("Argument '%s' may not be missing", vname);
    if (asInteger(x) < 0)
        error("Argument '%s' must be > 0", vname);

}

void assertNumber(SEXP x, const char *vname) {
    if (!isNumeric(x) || length(x) != 1)
        error("Argument '%s' must be a number", vname);
    if (any_missing_numeric(x))
        error("Argument '%s' may not be missing", vname);
}

void assertString(SEXP x, const char *vname) {
    if (!isString(x) || length(x) != 1)
        error("Argument '%s' must be a string", vname);
    if (any_missing_string(x))
        error("Argument '%s' may not be missing", vname);
}
