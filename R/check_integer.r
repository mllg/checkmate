#' Check if an argument is vector of type integer
#'
#' @note This function does not distinguish between
#' \code{NA}, \code{NA_integer_}, \code{NA_real_}, \code{NA_complex_}
#' and \code{NA_character_}.
#'
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
  if (! (is.integer(x) || (is.atomic(x) && allMissing(x))))
    return("'%s' must be integer")
  check_vector_props(x, ...) %and% check_bounds(x, lower, upper)
}
