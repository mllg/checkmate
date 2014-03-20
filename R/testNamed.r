testNamed = function(x) {
  nn = names(x)
  if (is.null(nn) || anyMissing(nn) || !all(nzchar(nn)))
    return("'%s' must be named")
  return(TRUE)
}

#' Check or assert that an argument is named
#'
#' @param x [ANY]\cr
#'  Object to check.
#' @return [\code{logical(1)}] Returns \code{TRUE} on success.
#'  Throws an exception on failure for assertion.
#' @export
checkNamed = function(x) {
  isTRUE(testNamed(x))
}

#' @rdname checkNamed
#' @export
assertNamed = function(x) {
  amsg(testNamed(x), deparse(substitute(x)))
}
