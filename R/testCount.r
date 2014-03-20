#' Checks if an argument is a count
#'
#' A count a a single integerish numeric which is not missing.
#'
#' @param x [\code{ANY}]\cr
#'  Object to check.
#' @return [\code{logical(1)}] Returns \code{TRUE} on success.
#'  Throws an exception on failure for assertion.
#' @export
checkCount = function(x) {
  length(x) == 1L && checkIntegerish(x) && !is.na(x)
}

#' @rdname checkCount
#' @export
assertCount = function(x) {
  if (!checkCount(x))
    amsg("'%s' must be a count", deparse(substitute(x)))
  invisible(TRUE)
}
