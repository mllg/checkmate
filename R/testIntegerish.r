#' Checks if an object is convertible to an integer.
#'
#' @templateVar id Integerish
#' @template testfuns
#' @inheritParams assertInteger
#' @param tol [\code{double(1)}]\cr
#'  Numerical tolerance used to check if a double can be converted.
#'  Default is \code{sqrt(.Machine$double.eps)}.
#' @param ... [ANY]\cr
#'  Additional parameters used in a call of \code{\link{isVector}}
#'  or \code{\link{assertVector}}.
#' @note \code{asIntegerish} converts the input to an integer.
#' @family basetypes
#' @export
#' @useDynLib checkmate c_is_integerish
assertIntegerish = function(x, lower, upper, tol = .Machine$double.eps^.5, ..., .var.name) {
  amsg(testIntegerish(x, lower, upper, tol, ...), vname(x, .var.name))
}

#' @rdname assertIntegerish
#' @export
isIntegerish = function(x, lower, upper, tol = .Machine$double.eps^.5, ...) {
  isTRUE(testIntegerish(x, lower, upper, tol, ...))
}

#' @rdname assertIntegerish
#' @export
asIntegerish = function(x, lower, upper, tol = .Machine$double.eps^.5, ..., .var.name) {
  assertIntegerish(x, lower, upper, tol, ..., .var.name = vname(x, .var.name))
  as.integer(x)
}

testIntegerish = function(x, lower, upper, tol = .Machine$double.eps^.5, ...) {
  if (!.Call("c_is_integerish", x, as.double(tol), PACKAGE = "checkmate"))
    return("'%s' must be integer-ish")
  testVectorProps(x, ...) %and% testBounds(x, lower, upper)
}
