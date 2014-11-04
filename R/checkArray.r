#' Check if an argument is an array
#'
#' @templateVar fn Array
#' @template x
#' @param mode [\code{character(1)}]\cr
#'  Storage mode of the matrix. Matricies can hold \dQuote{logical},
#'  \dQuote{integer}, \dQuote{double}, \dQuote{numeric}, \dQuote{complex} and
#'  \dQuote{character}. Default is \code{NULL} (no check).
#' @param any.missing [\code{logical(1)}]\cr
#'  Are missing values allowed? Default is \code{TRUE}.
#' @param d [\code{integer(1)}]\cr
#'  Dimensionality of array.
#'  Default is \code{NULL} (no check).
#' @template checker
#' @family basetypes
#' @useDynLib checkmate c_check_array
#' @export
#' @examples
#' checkArray(array(1:27, dim = c(3, 3, 3)), d = 3)
checkArray = function(x, mode = NULL, any.missing = TRUE, d = NULL) {
  .Call("c_check_array", x, mode, any.missing, d, PACKAGE = "checkmate")
}

#' @rdname checkArray
#' @useDynLib checkmate c_check_array
#' @export
assertArray = function(x, mode = NULL, any.missing = TRUE, d = NULL, .var.name) {
  res = .Call("c_check_array", x, mode, any.missing, d, PACKAGE = "checkmate")
  makeAssertion(res, vname(x, .var.name))
}

#' @rdname checkArray
#' @useDynLib checkmate c_check_array
#' @export
testArray = function(x, mode = NULL, any.missing = TRUE, d = NULL) {
  isTRUE(.Call("c_check_array", x, mode, any.missing, d, PACKAGE = "checkmate"))
}
