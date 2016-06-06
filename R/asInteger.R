#' Convert an argument to an integer
#'
#' @description
#' \code{asInteger} is intended to be used for vectors while \code{asInt} is
#' a specialization for scalar integers and \code{asCount} for scalar
#' non-negative integers.
#' Convertible are (a) atomic vectors with all elements \code{NA}
#' and (b) double vectors with all elements being within \code{tol}
#' range of an integer.
#'
#' @param x [any]\cr
#'  Object to convert.
#' @param ... [any]\cr
#'  Additional arguments passed to \code{\link{assertIntegerish}}.
#' @template tol
#' @template add
#' @template var.name
#' @return Converted \code{x}.
#' @export
#' @examples
#' asInteger(c(1, 2, 3))
#' asCount(1)
#' asInt(1)
asInteger = function(x, ..., tol = sqrt(.Machine$double.eps), .var.name = vname(x), add = NULL) {
  assertIntegerish(x, ..., tol = tol, .var.name = .var.name, add = add)
  storage.mode(x) = "integer"
  x
}

#' @rdname asInteger
#' @param positive [\code{logical(1)}]\cr
#'  Must \code{x} be positive (>= 1)?
#'  Default is \code{FALSE}.
#' @template na.ok
#' @export
asCount = function(x, na.ok = FALSE, positive = FALSE, tol = sqrt(.Machine$double.eps), .var.name = vname(x), add = NULL) {
  assertCount(x, na.ok, positive, tol, .var.name = .var.name, add = add)
  storage.mode(x) = "integer"
  x
}

#' @rdname asInteger
#' @template bounds
#' @export
asInt = function(x, na.ok = FALSE, lower = -Inf, upper = Inf, tol = sqrt(.Machine$double.eps), .var.name = vname(x), add = NULL) {
  assertInt(x, na.ok, lower, upper, tol, .var.name = .var.name, add = add)
  storage.mode(x) = "integer"
  x
}
