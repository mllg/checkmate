#' Check if an argument is a percentage
#'
#' @description
#' This checks \code{x} to be numeric and in the range \code{[0,1]}.
#'
#' @templateVar fn Percentage
#' @template x
#' @template na-handling
#' @param na.ok [\code{logical(1)}]\cr
#'  Are missing values allowed? Default is \code{FALSE}.
#' @template checker
#' @family scalars
#' @useDynLib checkmate c_check_number
#' @export
#' @examples
#' testPercentage(0.5)
#' testPercentage(1)
checkPercentage = function(x, na.ok = FALSE) {
  .Call("c_check_number", x, na.ok, 0.0, 1.0, FALSE, PACKAGE = "checkmate")
}
