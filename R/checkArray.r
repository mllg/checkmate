#' Check if an argument is an array
#'
#' @templateVar fn Array
#' @template x
#' @template mode
#' @param any.missing [\code{logical(1)}]\cr
#'  Are missing values allowed? Default is \code{TRUE}.
#' @param d [\code{integer(1)}]\cr
#'  Exact dimensionality of array \code{x}.
#'  Default is \code{NULL} (no check).
#' @param min.d [\code{integer(1)}]\cr
#'  Minimum dimensionality of array \code{x}.
#'  Default is \code{NULL} (no check).
#' @param max.d [\code{integer(1)}]\cr
#'  Maximum dimensionality of array \code{x}.
#'  Default is \code{NULL} (no check).
#' @template checker
#' @family basetypes
#' @useDynLib checkmate c_check_array
#' @export
#' @examples
#' checkArray(array(1:27, dim = c(3, 3, 3)), d = 3)
checkArray = function(x, mode = NULL, any.missing = TRUE, d = NULL, min.d = NULL, max.d = NULL) {
  .Call("c_check_array", x, mode, any.missing, d, min.d, max.d, PACKAGE = "checkmate")
}

#' @rdname checkArray
#' @useDynLib checkmate c_check_array
#' @export
assertArray = function(x, mode = NULL, any.missing = TRUE, d = NULL, min.d = NULL, max.d = NULL, .var.name) {
  res = .Call("c_check_array", x, mode, any.missing, d, min.d, max.d, PACKAGE = "checkmate")
  makeAssertion(res, vname(x, .var.name))
}

#' @rdname checkArray
#' @useDynLib checkmate c_check_array
#' @export
testArray = function(x, mode = NULL, any.missing = TRUE, d = NULL, min.d = NULL, max.d = NULL) {
  res = .Call("c_check_array", x, mode, any.missing, d, min.d, max.d, PACKAGE = "checkmate")
  isTRUE(res)
}
