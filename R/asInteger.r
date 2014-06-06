#' Convert an argument to an integer
#'
#' Convertible are (a) atomic vectors with all elements \code{NA}
#' and (b) double vectors with all elements being within \code{tol}
#' range of an integer.
#'
#' @param x [ANY]\cr
#'  Object to convert.
#' @param ... [ANY]\cr
#'  Additional arguments passed to \code{\link{checkInteger}}.
#' @param tol [\code{double(1)}]\cr
#'  Numerical tolerance used to check if a double or complex can be converted.
#'  Default is \code{sqrt(.Machine$double.eps)}.
#' @param .var.name [character(1)]\cr
#'  Name for \code{x}. Defaults to a heuristic to determine
#'  the name using \code{\link[base]{deparse}} and \code{\link[base]{substitute}}.
#' @return Converted \code{x}.
#' @export
asInteger = function(x, ..., tol = .Machine$double.eps^0.5, .var.name) {
  assertIntegerish(x, ..., tol = tol, .var.name = vname(x, .var.name))
  as.integer(x)
}

asCount = function(x, na.ok = FALSE, positive = FALSE, .var.name) {
  assertCount(x, na.ok, positive, vname(x, .var.name))
  as.integer(x)
}
