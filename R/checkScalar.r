#' Check if an argument is a single atomic value
#'
#' @templateVar fn Scalar
#' @template x
#' @template na-handling
#' @param na.ok [\code{logical(1)}]\cr
#'  Are missing values allowed? Default is \code{FALSE}.
#' @template checker
#' @family scalars
#' @useDynLib checkmate c_check_scalar
#' @export
#' @examples
#' testScalar(1)
#' testScalar(1:10)
checkScalar = function(x, na.ok = FALSE) {
  .Call("c_check_scalar", x, na.ok, PACKAGE = "checkmate")
}
