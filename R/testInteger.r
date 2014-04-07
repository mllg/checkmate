#' Checks if an argument is an integer
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
  amsg(testVectorProps(x, ...), vname(x, .var.name))
  amsg(testInteger(x), vname(x, .var.name))
}

#' @rdname assertInteger
#' @export
isInteger = function(x, lower, upper, ...) {
  isTRUE(testVectorProps(x, ...)) && isTRUE(testInteger(x, lower, upper))
}

#' @rdname assertInteger
#' @export
asInteger = function(x, ..., .var.name) {
  assertInteger(x, ..., .var.name = vname(x, .var.name))
  x
}

testInteger = function(x, lower, upper) {
  if (!is.integer(x))
    return("'%s' must be integer")
  if (!missing(lower) && qassert(lower, "N1") && any(x < lower))
    return(sprintf("All elements of '%%s' must be >= %s", lower))
  if (!missing(upper) && qassert(upper, "N1") && any(x > upper))
    return(sprintf("All elements of '%%s' must be <= %s", upper))
  return(TRUE)
}
