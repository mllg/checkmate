#' Check if an argument is an integer vector
#'
#' @template checker
#' @param lower [\code{numeric(1)}]\cr
#'  Lower value all elements of \code{x} must be greater than.
#' @param upper [\code{numeric(1)}]\cr
#'  Upper value all elements of \code{x} must be lower than.
#' @param ... [ANY]\cr
#'  Additional parameters used in a call of \code{\link{check_vector}}.
#' @family checker
#' @export
#' @examples
#'  test(1L, "integer")
#'  test(1., "integer")
check_integer = function(x, lower, upper, ...) {
  if (!is.integer(x))
    return("'%s' must be integer")
  check_vector_props(x, ...) %and% check_bounds(x, lower, upper)
}
