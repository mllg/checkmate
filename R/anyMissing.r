#' Checks if an object contains missing values
#'
#' Supported are atomic types (see \code{\link[base]{is.atomic}}), lists and data frames.
#' Missingness is defined as \code{NA} or \code{NaN} for atomics and
#' \code{NULL} for lists.
#'
#' @param x [\code{ANY}]\cr
#'  Object to check.
#' @return [\code{logical(1)}] Returns \code{TRUE} if any (\code{anyMissing}) or all (\code{allMissing})
#'  elements of \code{x} are missing (see details), \code{FALSE} otherwise.
#' @useDynLib checkmate c_any_missing
#' @export
anyMissing = function(x) {
  .Call("c_any_missing", x, PACKAGE = "checkmate")
}
