mstop = function(msg, ...) {
  stop(simpleError(message = sprintf(msg, ...), call = sys.call(1L)))
}

"%and%" = function(lhs, rhs) {
  if (identical(lhs, TRUE)) rhs else lhs
}

"%nin%" = function(x, y) {
  !match(x, y, nomatch = 0L)
}

convertCamelCase = function(x) {
  tolower(gsub("((?<=[a-z0-9])[A-Z]|(?!^)[A-Z](?=[a-z]))", "_\\1", x, perl = TRUE))
}

#' @useDynLib checkmate c_guess_type
guessType = function(x) {
  .Call(c_guess_type, x)
}

isSameType = function(x, y) {
  identical(typeof(x), typeof(y)) || (is.numeric(x) && is.numeric(y))
}
