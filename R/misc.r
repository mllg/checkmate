#' A wrapper for \code{identical(x, FALSE)}.
#'
#' @param x [any]\cr
#'   Your object.
#' @return [\code{logical(1)}].
#' @export
#' @examples
#' isFALSE(0)
#' isFALSE(FALSE)
isFALSE = function(x) {
  identical(x, FALSE)
}
