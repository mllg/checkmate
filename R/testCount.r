#' Checks if an argument is a count
#'
#' A count a a single integerish numeric >= 0 which is not missing.
#'
#' @param x [\code{ANY}]\cr
#'  Object to check.
#' @param .var.name [\code{logical(1)}]\cr
#'  Argument name to print in error message. If missing,
#'  the name of \code{x} will be retrieved via \code{\link[base]{substitute}}.
#' @return [\code{logical(1)}] Returns \code{TRUE} on success.
#'  Throws an exception on failure for assertion.
#' @export
assertCount = function(x, .var.name) {
  amsg(testCount(x), vname(x, .var.name))
}

#' @rdname assertCount
#' @export
checkCount = function(x) {
  isTRUE(testCount(x))
}

testCount = function(x) {
  if (length(x) != 1L || !checkIntegerish(x) || is.na(x) || x < 0)
    return("'%s' must be a count")
  return(TRUE)
}
