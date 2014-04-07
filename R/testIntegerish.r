#' Checks if an object is convertible to an integer.
#'
#' @templateVar id Integerish
#' @template testfuns
#' @param tol [\code{double(1)}]\cr
#'  Numerical tolerance used to check if a double can be converted.
#'  Default is \code{sqrt(.Machine$double.eps)}.
#' @param ... [ANY]\cr
#'  Additional parameters used in a call of \code{\link{isVector}}
#'  or \code{\link{assertVector}}.
#' @family basetypes
#' @export
#' @useDynLib checkmate c_is_integerish
assertIntegerish = function(x, tol = .Machine$double.eps^.5, ..., .var.name) {
  amsg(testVectorProps(x, ...), vname(x, .var.name))
  amsg(testIntegerish(x, tol), vname(x, .var.name))
}

#' @rdname assertIntegerish
#' @export
isIntegerish = function(x, tol = .Machine$double.eps^.5, ...) {
  isTRUE(testVectorProps(x, ...)) && isTRUE(testIntegerish(x, tol))
}

#' @rdname assertIntegerish
#' @export
asIntegerish = function(x, tol = .Machine$double.eps^.5, ..., .var.name) {
  assertIntegerish(x, tol = tol, ..., .var.name = vname(x, .var.name))
  as.integer(x)
}

testIntegerish = function(x, tol = .Machine$double.eps^.5) {
  if (!.Call("c_is_integerish", x, as.double(tol), PACKAGE = "checkmate"))
    return("'%s' must be integer-ish")
  return(TRUE)
}
