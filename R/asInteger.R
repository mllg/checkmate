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
#' Note that these functions may be deprecated in the future.
#' Instead, it is advised to use \code{\link{assertCount}},
#' \code{\link{assertInt}} or \code{\link{assertIntegerish}} with
#' argument \code{coerce} set to \code{TRUE} instead.
#'
#' @param x [any]\cr
#'  Object to convert.
#' @template na-handling
#' @inheritParams checkInteger
#' @inheritParams checkVector
#' @template tol
#' @template var.name
#' @return Converted \code{x}.
#' @export
#' @examples
#' asInteger(c(1, 2, 3))
#' asCount(1)
#' asInt(1)
asInteger = function(x, tol = sqrt(.Machine$double.eps), lower = -Inf, upper = Inf, any.missing = TRUE, all.missing = TRUE, len = NULL, min.len = NULL, max.len = NULL, unique = FALSE, sorted = FALSE, names = NULL, .var.name = vname(x)) {
  assertIntegerish(x, tol = tol, lower = lower, upper = upper, any.missing = any.missing, all.missing = all.missing, len = len, min.len = min.len, max.len = max.len, unique = unique, sorted = sorted, names = names, null.ok = FALSE, .var.name = .var.name)
  storage.mode(x) = "integer"
  x
}

#' @rdname asInteger
#' @param positive [\code{logical(1)}]\cr
#'  Must \code{x} be positive (>= 1)?
#'  Default is \code{FALSE}.
#' @template na.ok
#' @export
asCount = function(x, na.ok = FALSE, positive = FALSE, tol = sqrt(.Machine$double.eps), .var.name = vname(x)) {
  assertCount(x, na.ok, positive, tol, .var.name = .var.name)
  storage.mode(x) = "integer"
  x
}

#' @rdname asInteger
#' @template bounds
#' @export
asInt = function(x, na.ok = FALSE, lower = -Inf, upper = Inf, tol = sqrt(.Machine$double.eps), .var.name = vname(x)) {
  assertInt(x, na.ok, lower, upper, tol, .var.name = .var.name)
  storage.mode(x) = "integer"
  x
}
