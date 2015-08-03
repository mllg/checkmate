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
#' @param add [\code{AssertCollection}]\cr
#'  Collection to store assertions. See \code{\link{AssertCollection}}.
#' @param .var.name [character(1)]\cr
#'  Name for \code{x}. Defaults to a heuristic to determine
#'  the name using \code{\link[base]{deparse}} and \code{\link[base]{substitute}}.
#' @return Converted \code{x}.
#' @export
#' @examples
#' asInteger(c(1, 2, 3))
#' asCount(1)
#' asInt(1)
asInteger = function(x, ..., tol = sqrt(.Machine$double.eps), add = NULL, .var.name) {
  assertIntegerish(x, ..., tol = tol, .var.name = vname(x, .var.name), add = NULL)
  storage.mode(x) = "integer"
  x
}

#' @rdname asInteger
#' @param positive [\code{logical(1)}]\cr
#'  Must \code{x} be positive (>= 1)?
#'  Default is \code{FALSE}.
#' @param na.ok [\code{logical(1)}]\cr
#'  Are missing values allowed? Default is \code{FALSE}.
#' @export
asCount = function(x, na.ok = FALSE, positive = FALSE, tol = sqrt(.Machine$double.eps), add = NULL, .var.name) {
  assertCount(x, na.ok, positive, tol, vname(x, .var.name), add = NULL)
  storage.mode(x) = "integer"
  x
}

#' @rdname asInteger
#' @template bounds
#' @export
asInt = function(x, na.ok = FALSE, lower = -Inf, upper = Inf, tol = sqrt(.Machine$double.eps), add = NULL, .var.name) {
  assertInt(x, na.ok, lower, upper, tol, vname(x, .var.name), add = NULL)
  storage.mode(x) = "integer"
  x
}
