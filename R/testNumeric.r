testNumeric = function(x, lower, upper) {
  if (!is.numeric(x))
    return("'%s' must be numeric")
  if (!missing(lower) && qassert(lower, "N1") && any(x < lower))
    return(sprintf("All elements of '%%s' must be >= %s", lower))
  if (!missing(upper) && qassert(upper, "N1") && any(x > upper))
    return(sprintf("All elements of '%%s' must be <= %s", upper))
  return(TRUE)
}

#' Checks if an argument is a numeric
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
#' @param .var.name [\code{logical(1)}]\cr
#'  Argument name to print in error message. If missing,
#'  the name of \code{x} will be retrieved via \code{\link[base]{substitute}}.
#' @return [\code{logical(1)}] Returns \code{TRUE} on success.
#'  Throws an exception on failure for assertion.
#' @export
assertNumeric = function(x, lower, upper, ..., .var.name) {
  amsg(testVectorProps(x), vname(x, .var.name))
  amsg(testNumeric(x), vname(x, .var.name))
}

#' @rdname assertNumeric
#' @export
checkNumeric = function(x, lower, upper, ...) {
  isTRUE(testVectorProps(x, ...)) && isTRUE(testNumeric(x, lower, upper))
}
