#' Check if an object contains NaN values
#'
#' @description
#' Supported are atomic types (see \code{\link[base]{is.atomic}}), lists and data frames.
#'
#' @param x [\code{ANY}]\cr
#'  Object to check.
#' @return [\code{logical(1)}] Returns \code{TRUE} if any element if \code{NaN}.
#' @useDynLib checkmate c_any_nan
#' @export
#' @examples
#' anyNaN(1:10)
#' anyNaN(c(1:10, NaN))
#' iris[3, 3] = NaN
#' anyNaN(iris)
anyNaN = function(x) {
  .Call(c_any_nan, x)
}
