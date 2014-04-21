#' Check if an argument is a numeric vector
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
#'  test(1L, "numeric")
#'  test(1., "numeric")
check_numeric = function(x, lower, upper, ...) {
  if (!is.numeric(x))
    return("'%s' must be numeric")
  check_vector_props(x, ...) %and% check_bounds(x, lower, upper)
}
