testCount = function(x) {
  if (length(x) != 1L || !checkIntegerish(x) || is.na(x) || x < 0)
    return("'%s' must be a count")
  return(TRUE)
}
#' Checks if an argument is a count
#'
#' A count a a single integerish numeric >= 0 which is not missing.
#'
#' @param x [\code{ANY}]\cr
#'  Object to check.
#' @return [\code{logical(1)}] Returns \code{TRUE} on success.
#'  Throws an exception on failure for assertion.
#' @export
checkCount = function(x) {
  isTRUE(testCount(x))
}

#' @rdname checkCount
#' @export
assertCount = function(x) {
  amsg(testCount(x), dps(x))
}
