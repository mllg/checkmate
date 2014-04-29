library(microbenchmark)
library(checkmate)

pr = function(mb, unit) {
  print(mb, unit = unit, order="median")
}

x = FALSE
pr(microbenchmark(
    # fastest, but you have to deal with error messages yourself
    if (length(x) != 1L || !is.logical(x) || is.na(x)) stop("error"),
    # 3rd, horrible error messages
    stopifnot(length(x) == 1L && is.logical(x) && !is.na(x)),
    # 2nd, with useful error messages
    qassert(x, "B1"),
    # 4rd
    assert(x, "flag", na.ok = FALSE),
    # 5th
    checkArg(x, "logical", len = 1, na.ok = FALSE)
))

x = 1:10
pr(microbenchmark(
    if (!is.integer(x) || length(x) == 0 || any(x < 0)) stop("error"),
    qassert(x, "i+[1,)"),
    stopifnot(is.integer(x) && length(x) >= 1 && all(x >= 1)),
    assert(x, "integer", min.len = 1, lower = 1),
    checkArg(x, "integer", min.len = 1, lower = 1)
))

x = letters
pr(microbenchmark(
    if (!is.character(x) || length(x) < 10 || any(is.na(x))) stop("error"),
    qassert(x, "S>=10"),
    stopifnot(is.character(x) && length(x) >= 10 && all(!is.na(x))),
    assert(x, "character", min.len = 10, any.missing = FALSE),
    checkArg(x, "character", min.len = 10, na.ok = FALSE)
))

# dominated by logical creation in is.na
x = runif(1e6)
pr(microbenchmark(
    if (!is.numeric(x) || any(is.na(x))) stop("error"),
    qassert(x, "N"),
    stopifnot(is.numeric(x) && all(!is.na(x))),
    assert(x, "numeric", any.missing = FALSE),
    checkArg(x, "numeric", na.ok = FALSE)
))

# faster than plain R?
x = runif(1e6)
pr(microbenchmark(
    if (!is.numeric(x) || any(x < 0)) stop("error"),
    qassert(x, "N[0,]"),
    stopifnot(is.numeric(x) && all(x >= 0)),
    assert(x, "numeric", lower = 0),
    checkArg(x, "numeric", lower = 0)
))
