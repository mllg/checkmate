#' Check if an argument is vector of type integer
#'
#' @template na-handling
#' @template checker
#' @param lower [\code{numeric(1)}]\cr
#'  Lower value all elements of \code{x} must be greater than or equal.
#' @param upper [\code{numeric(1)}]\cr
#'  Upper value all elements of \code{x} must be lower than or equal.
#' @param ... [ANY]\cr
#'  Additional parameters used in a call of \code{\link{check_vector}}.
#' @family basetypes
#' @export
#' @examples
#'  test(1L, "integer")
#'  test(1., "integer")
#'  test(1:2, "integer", lower = 1, upper = 2, any.missing = FALSE)
check_integer = function(x, lower, upper, ...) {
  if (!is.integer(x) && !allMissingAtomic(x))
    return(mustBeClass("integer"))
  check_vector_props(x, ...) %and% check_bounds(x, lower, upper)
}
