#' Checks if an argument is an integer vector
#'
#' @templateVar id Integer
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
assertInteger = function(x, lower, upper, ..., .var.name) {
  amsg(testInteger(x, lower, upper, ...), vname(x, .var.name))
}

#' @rdname assertInteger
#' @export
isInteger = function(x, lower, upper, ...) {
  isTRUE(testInteger(x, lower, upper, ...))
}

#' @rdname assertInteger
#' @export
asInteger = function(x, lower, upper, ..., .var.name) {
  assertInteger(x, lower, upper, ..., .var.name = vname(x, .var.name))
  x
}

testInteger = function(x, lower, upper, ...) {
  if (!is.integer(x))
    return("'%s' must be integer")
  testVectorProps(x, ...) %and% testBounds(x, lower, upper)
}
