#' Check if an argument is a vector of type numer
#'
#' @note This function does not distinguish between
#' \code{NA}, \code{NA_integer_}, \code{NA_real_}, \code{NA_complex_}
#' and \code{NA_character_}.
#'
#' @template checker
#' @param lower [\code{numeric(1)}]\cr
#'  Lower value all elements of \code{x} must be greater than.
#' @param upper [\code{numeric(1)}]\cr
#'  Upper value all elements of \code{x} must be lower than.
#' @param ... [ANY]\cr
#'  Additional parameters used in a call of \code{\link{check_vector}}.
#' @family basetypes
#' @export
#' @examples
#'  test(1, "numeric")
#'  test(1, "numeric", min.len = 1, lower = 0)
check_numeric = function(x, lower, upper, ...) {
  if (!is.numeric(x) && !allMissingAtomic(x))
    return("'%s' must be numeric")
  check_vector_props(x, ...) %and% check_bounds(x, lower, upper)
}
