#' Checks if an object contains missing values.
#'
#' Supported are atomic types (see \code{\link[base]{is.atomic}}), lists and data frames.
#' Missingness is defined ias \code{NA} or \code{NaN} for atomic types and
#' \code{NULL} for lists.
#'
#' @param x [\code{ANY}]\cr
#'  Object to check.
#' @return [\code{logical(1)}] Returns \code{TRUE} if at least one element of \code{x} is missing (see details).
#' @useDynLib checkmate c_any_missing
#' @export
anyMissing = function(x) {
  .Call("c_any_missing", x, PACKAGE = "checkmate")
}
