#' Check if an object is an integerish vector
#'
#' @template na-handling
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
  qassert(tol, "N1")
  if (!isIntegerish(x, tol) && !allMissingAtomic(x))
    return("'%s' must be integer-ish")
  check_vector_props(x, ...) %and% check_bounds(x, lower, upper)
}

isIntegerish = function(x, tol = .Machine$double.eps^.5) {
  .Call("c_is_integerish", x, as.double(tol), PACKAGE = "checkmate")
}
