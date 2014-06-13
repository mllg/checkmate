#' Convert an argument to an integer
#'
#' \code{asInteger} is intended to be used for vectors while \code{asInt} is
#' a specialization for scalar integers and \code{asCount} for scalar
#' non-negative integers.
#' Convertible are (a) atomic vectors with all elements \code{NA}
#' and (b) double vectors with all elements being within \code{tol}
#' range of an integer.
#'
#' @param x [ANY]\cr
#'  Object to convert.
#' @param ... [ANY]\cr
#'  Additional arguments passed to \code{\link{checkInteger}}.
#' @param tol [\code{double(1)}]\cr
#'  Numerical tolerance used to check whether a double or complex can be converted.
#'  Default is \code{sqrt(.Machine$double.eps)}.
#' @param .var.name [character(1)]\cr
#'  Name for \code{x}. Defaults to a heuristic to determine
#'  the name using \code{\link[base]{deparse}} and \code{\link[base]{substitute}}.
#' @return Converted \code{x}.
#' @export
#' @examples
#'  asInteger(c(1, 2, 3))
#'  asCount(1)
#'  asInt(1)
asInteger = function(x, ..., tol = .Machine$double.eps^0.5, .var.name) {
  assertIntegerish(x, ..., tol = tol, .var.name = vname(x, .var.name))
  as.integer(x)
}

#' @rdname asInteger
#' @param positive [\code{logical(1)}]\cr
#'  Must \code{x} be positive (>= 1)?
#'  Default is \code{FALSE}.
#' @param na.ok [\code{logical(1)}]\cr
#'  Are missing values allowed? Default is \code{FALSE}.
#' @export
asCount = function(x, na.ok = FALSE, positive = FALSE, .var.name) {
  assertCount(x, na.ok, positive, vname(x, .var.name))
  as.integer(x)
}

#' @rdname asInteger
#' @param lower [\code{numeric(1)}]\cr
#'  Lower value all elements of \code{x} must be greater than.
#' @param upper [\code{numeric(1)}]\cr
#'  Upper value all elements of \code{x} must be lower than.
#' @export
asInt = function(x, na.ok = FALSE, lower = -Inf, upper = Inf, .var.name) {
  assertInt(x, na.ok, lower, upper, .var.name)
  as.integer(x)
}
