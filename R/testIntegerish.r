#' Checks if an object is convertible to an integer.
#'
#' @param x [\code{ANY}]\cr
#'  Object to check.
#' @param tol [\code{double(1)}]\cr
#'  Numerical tolerance used to check if a double can be converted.
#'  Default is \code{sqrt(.Machine$double.eps)}.
#' @return [\code{logical(1)}] Returns \code{TRUE} on success.
#'  Throws an exception on failure for assertion.
#' @export
#' @useDynLib checkmate c_is_integerish
#' @export
checkIntegerish = function(x, tol = .Machine$double.eps^.5) {
  .Call("c_is_integerish", x, as.double(tol), PACKAGE = "checkmate")
}

#' @rdname checkIntegerish
#' @export
assertIntegerish = function(x, tol = .Machine$double.eps^.5) {
  if (!checkIntegerish(x, tol))
    stop("Error checking '", deparse(substitute(x)), "': Must be integer-ish")
  invisible(TRUE)
}
