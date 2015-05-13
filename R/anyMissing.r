#' Check if an object contains missing values
#'
#' @description
#' Supported are atomic types (see \code{\link[base]{is.atomic}}), lists and data frames.
#' Missingness is defined as \code{NA} or \code{NaN} for atomic types and data frame columns,
#' \code{NULL} is defined as missing for lists.
#'
#' @param x [\code{ANY}]\cr
#'  Object to check.
#' @return [\code{logical(1)}] Returns \code{TRUE} if any (\code{anyMissing}) or all (\code{allMissing})
#'  elements of \code{x} are missing (see details), \code{FALSE} otherwise.
#' @useDynLib checkmate c_any_missing
#' @export
#' @examples
#' anyMissing(c(1, 1))
#' anyMissing(c(1, NA))
#' anyMissing(list(1, NULL))
anyMissing = function(x) {
  .Call("c_any_missing", x, PACKAGE = "checkmate")
}
