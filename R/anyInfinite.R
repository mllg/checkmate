#' Check if an object contains infinite values
#'
#' @description
#' Supported are atomic types (see \code{\link[base]{is.atomic}}), lists and data frames.
#'
#' @param x [\code{ANY}]\cr
#'  Object to check.
#' @return [\code{logical(1)}] Returns \code{TRUE} if any element if \code{-Inf} or \code{Inf}.
#' @useDynLib checkmate c_any_infinite
#' @export
#' @examples
#' anyInfinite(1:10)
#' anyInfinite(c(1:10, Inf))
#' iris[3, 3] = Inf
#' anyInfinite(iris)
anyInfinite = function(x) {
  .Call(c_any_infinite, x)
}
