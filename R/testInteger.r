testInteger = function(x, lower, upper) {
  if (!is.integer(x))
    return("'%s' must be integer")
  if (!missing(lower) && qassert(lower, "N1") && any(x < lower))
    return(sprintf("All elements of '%%s' must be >= %s", lower))
  if (!missing(upper) && qassert(upper, "N1") && any(x > upper))
    return(sprintf("All elements of '%%s' must be <= %s", upper))
  return(TRUE)
}

#' Checks if an argument is an integer
#'
#' @param x [\code{ANY}]\cr
#'  Object to check.
#' @param lower [\code{numeric(1)}]\cr
#'  Lower value all elements of \code{x} must be greater than.
#' @param upper [\code{numeric(1)}]\cr
#'  Upper value all elements of \code{x} must be lower than.
#' @param ... [ANY]\cr
#'  Additional parameters used in a call of \code{\link{checkVector}}
#'  or \code{\link{assertVector}}.
#' @return [\code{logical(1)}] Returns \code{TRUE} on success.
#'  Throws an exception on failure for assertion.
#' @export
checkInteger = function(x, lower, upper, ...) {
  isTRUE(testVectorProps(x, ...)) && isTRUE(testInteger(x, lower, upper))
}

#' @rdname checkInteger
#' @export
assertInteger = function(x, lower, upper, ...) {
  amsg(testVectorProps(x), dps(x))
  amsg(testInteger(x), dps(x))
}
