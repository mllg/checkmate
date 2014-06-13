#' Check if an argument is an array
#'
#' @templateVar fn Array
#' @template checker
#' @param any.missing [\code{logical(1)}]\cr
#'  Are missing values allowed? Default is \code{TRUE}.
#' @param d [\code{integer}]\cr
#'  Dimensionality of array.
#' @family basetypes
#' @useDynLib checkmate c_check_array
#' @export
checkArray = function(x, any.missing = TRUE, d = NULL) {
  .Call("c_check_array", x, any.missing, d, PACKAGE = "checkmate")
}

#' @rdname checkArray
#' @useDynLib checkmate c_check_array
#' @export
assertArray = function(x, any.missing = TRUE, d = NULL, .var.name) {
  makeAssertion(
    .Call("c_check_array", x, any.missing, d, PACKAGE = "checkmate")
  , vname(x, .var.name))
}

#' @rdname checkArray
#' @useDynLib checkmate c_check_array
#' @export
testArray = function(x, any.missing = TRUE, d = NULL) {
  isTRUE(
    .Call("c_check_array", x, any.missing, d, PACKAGE = "checkmate")
  )
}
