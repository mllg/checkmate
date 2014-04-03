testIntegerish = function(x, tol = .Machine$double.eps^.5) {
  if (!.Call("c_is_integerish", x, as.double(tol), PACKAGE = "checkmate"))
    return("'%s' must be integer-ish")
  return(TRUE)
}
#' Checks if an object is convertible to an integer.
#'
#' @param x [\code{ANY}]\cr
#'  Object to check.
#' @param tol [\code{double(1)}]\cr
#'  Numerical tolerance used to check if a double can be converted.
#'  Default is \code{sqrt(.Machine$double.eps)}.
#' @param ... [ANY]\cr
#'  Additional parameters used in a call of \code{\link{checkVector}}
#'  or \code{\link{assertVector}}.
#' @return [\code{logical(1)}] Returns \code{TRUE} on success.
#'  Throws an exception on failure for assertion.
#' @export
#' @useDynLib checkmate c_is_integerish
#' @export
checkIntegerish = function(x, tol = .Machine$double.eps^.5, ...) {
  isTRUE(testVector(x, ...)) && isTRUE(testIntegerish(x, tol))
}

#' @rdname checkIntegerish
#' @export
assertIntegerish = function(x, tol = .Machine$double.eps^.5, ...) {
  amsg(testVector(x, ...), dps(x))
  amsg(testIntegerish(x, tol), dps(x))
}
