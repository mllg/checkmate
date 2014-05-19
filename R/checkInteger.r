#' Check if an argument is vector of type integer
#'
#' @templateVar fn Integer
#' @template na-handling
#' @template checker
#' @param lower [\code{numeric(1)}]\cr
#'  Lower value all elements of \code{x} must be greater than or equal.
#' @param upper [\code{numeric(1)}]\cr
#'  Upper value all elements of \code{x} must be lower than or equal.
#' @param ... [ANY]\cr
#'  Additional parameters used in a call of \code{\link{checkVector}}.
#' @family basetypes
#' @export
#' @examples
#'  test(1L, "integer")
#'  test(1., "integer")
#'  test(1:2, "integer", lower = 1, upper = 2, any.missing = FALSE)
checkInteger = function(x, lower = -Inf, upper = Inf, ...) {
  if (!is.integer(x) && !allMissingAtomic(x))
    return(mustBeClass("integer"))
  checkVectorProps(x, ...) %and% checkBounds(x, lower, upper)
}

#' @rdname checkInteger
#' @export
assertInteger = function(x, lower = -Inf, upper = Inf, ..., .var.name) {
  makeAssertion(checkInteger(x, lower, upper, ...), vname(x, .var.name))
}

#' @rdname checkInteger
#' @export
testInteger = function(x, lower = -Inf, upper = Inf, ...) {
  makeTest(checkInteger(x, lower, upper, ...))
}
