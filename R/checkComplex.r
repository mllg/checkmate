#' Check if an argument is a vector of type complex
#'
#' @templateVar fn Complex
#' @template na-handling
#' @template checker
#' @inheritParams checkVector
#' @family basetypes
#' @useDynLib checkmate c_check_complex
#' @export
#' @examples
#'  testComplex(1)
#'  testComplex(1+1i)
checkComplex = function(x, any.missing = TRUE, all.missing = TRUE, len = NULL, min.len = NULL, max.len = NULL, unique = FALSE, names = NULL) {
  .Call("c_check_complex", x, any.missing, all.missing, len, min.len, max.len, unique, names, PACKAGE = "checkmate")
}

#' @rdname checkComplex
#' @useDynLib checkmate c_check_complex
#' @export
assertComplex = function(x, any.missing = TRUE, all.missing = TRUE, len = NULL, min.len = NULL, max.len = NULL, unique = FALSE, names = NULL, .var.name) {
  makeAssertion(
    .Call("c_check_complex", x, any.missing, all.missing, len, min.len, max.len, unique, names, PACKAGE = "checkmate")
  , vname(x, .var.name))
}

#' @rdname checkComplex
#' @useDynLib checkmate c_check_complex
#' @export
testComplex = function(x, any.missing = TRUE, all.missing = TRUE, len = NULL, min.len = NULL, max.len = NULL, unique = FALSE, names = NULL) {
  isTRUE(
    .Call("c_check_complex", x, any.missing, all.missing, len, min.len, max.len, unique, names, PACKAGE = "checkmate")
  )
}
