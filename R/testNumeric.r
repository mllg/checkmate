#' Checks if an argument is a numeric
#'
#' @templateVar id Numeric
#' @template testfuns
#' @param lower [\code{numeric(1)}]\cr
#'  Lower value all elements of \code{x} must be greater than.
#' @param upper [\code{numeric(1)}]\cr
#'  Upper value all elements of \code{x} must be lower than.
#' @param ... [ANY]\cr
#'  Additional parameters used in a call of \code{\link{isVector}}
#'  or \code{\link{assertVector}}.
#' @family basetypes
#' @export
assertNumeric = function(x, lower, upper, ..., .var.name) {
  amsg(testNumeric(x, lower, upper, ...), vname(x, .var.name))
}

#' @rdname assertNumeric
#' @export
isNumeric = function(x, lower, upper, ...) {
  isTRUE(testNumeric(x, lower, upper, ...))
}

#' @rdname assertNumeric
#' @export
asNumeric = function(x, lower, upper, ..., .var.name) {
  assertNumeric(x, lower, upper, ... , .var.name = vname(x, .var.name))
  x
}

testNumeric = function(x, lower, upper, ...) {
  if (!is.numeric(x))
    return("'%s' must be numeric")
  testVectorProps(x, ...) %and% testBounds(x, lower, upper)
}
