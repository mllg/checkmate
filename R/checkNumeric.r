#' Check that an argument is a vector of type numeric
#'
#' @templateVar fn Numeric
#' @template na-handling
#' @template checker
#' @param lower [\code{numeric(1)}]\cr
#'  Lower value all elements of \code{x} must be greater than.
#' @param upper [\code{numeric(1)}]\cr
#'  Upper value all elements of \code{x} must be lower than.
#' @param ... [ANY]\cr
#'  Additional parameters used in a call of \code{\link{checkVector}}.
#' @family basetypes
#' @export
#' @examples
#'  test(1, "numeric")
#'  test(1, "numeric", min.len = 1, lower = 0)
checkNumeric = function(x, lower = -Inf, upper = Inf, ...) {
  if (!is.numeric(x) && !allMissingAtomic(x))
    return("Must be numeric")
  checkVectorProps(x, ...) %and% checkBounds(x, lower, upper)
}

#' @rdname checkNumeric
#' @export
assertNumeric = function(x, lower = -Inf, upper = Inf, ..., .var.name) {
  makeAssertion(checkNumeric(x, lower, upper, ...), vname(x, .var.name))
}

#' @rdname checkNumeric
#' @export
testNumeric = function(x, lower = -Inf, upper = Inf, ...) {
  isTRUE(checkNumeric(x, lower, upper, ...))
}
