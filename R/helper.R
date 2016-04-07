mstop = function(msg, ...) {
  stop(simpleError(sprintf(msg, ...), call = sys.call(1L)))
}

"%and%" = function(lhs, rhs) {
  if (identical(lhs, TRUE)) rhs else lhs
}

"%nin%" = function(x, y) {
  !match(x, y, nomatch = 0L)
}

setClasses = function(x, cl) {
  class(x) = cl
  x
}

convertCamelCase = function(x) {
  tolower(gsub("((?<=[a-z0-9])[A-Z]|(?!^)[A-Z](?=[a-z]))", "_\\1", x, perl = TRUE))
}
