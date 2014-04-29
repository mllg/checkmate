#' Check if an object is an integerish vector
#'
#' @note This function does not distinguish between
#' \code{NA}, \code{NA_integer_}, \code{NA_real_}, \code{NA_complex_}
#' and \code{NA_character_}.
#'
#' @template checker
#' @inheritParams check_integer
#' @param tol [\code{double(1)}]\cr
#'  Numerical tolerance used to check if a double or complex can be converted.
#'  Default is \code{sqrt(.Machine$double.eps)}.
#' @param ... [ANY]\cr
#'  Additional parameters used in a call of \code{\link{check_vector}}.
#' @family basetypes
#' @export
#' @useDynLib checkmate c_is_integerish
#' @examples
#'  test(1L, "integerish")
#'  test(1., "integerish")
#'  test(1:2, "integerish", lower = 1L, upper = 2L, any.missing = FALSE)
check_integerish = function(x, lower, upper, tol = .Machine$double.eps^.5, ...) {
  if (! (.Call("c_is_integerish", x, as.double(tol), PACKAGE = "checkmate") || (is.atomic(x) && allMissing(x))))
    return("'%s' must be integer-ish")
  check_vector_props(x, ...) %and% check_bounds(x, lower, upper)
}
