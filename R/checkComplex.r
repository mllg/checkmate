#' Check if an argument is a vector of type complex
#'
#' @templateVar fn Complex
#' @template x
#' @template na-handling
#' @inheritParams checkVector
#' @template checker
#' @family basetypes
#' @useDynLib checkmate c_check_complex
#' @export
#' @examples
#' testComplex(1)
#' testComplex(1+1i)
checkComplex = function(x, any.missing = TRUE, all.missing = TRUE, len = NULL, min.len = NULL, max.len = NULL, unique = FALSE, names = NULL) {
  .Call("c_check_complex", x, any.missing, all.missing, len, min.len, max.len, unique, names, PACKAGE = "checkmate")
}

#' @rdname checkComplex
#' @useDynLib checkmate c_check_complex
#' @export
assertComplex = function(x, any.missing = TRUE, all.missing = TRUE, len = NULL, min.len = NULL, max.len = NULL, unique = FALSE, names = NULL, .var.name) {
  res = .Call("c_check_complex", x, any.missing, all.missing, len, min.len, max.len, unique, names, PACKAGE = "checkmate")
  makeAssertion(res, vname(x, .var.name))
}

#' @rdname checkComplex
#' @useDynLib checkmate c_check_complex
#' @export
testComplex = function(x, any.missing = TRUE, all.missing = TRUE, len = NULL, min.len = NULL, max.len = NULL, unique = FALSE, names = NULL) {
  res = .Call("c_check_complex", x, any.missing, all.missing, len, min.len, max.len, unique, names, PACKAGE = "checkmate")
  isTRUE(res)
}

#' @rdname checkComplex
#' @template expect
#' @useDynLib checkmate c_check_complex
#' @export
expect_complex = function(x, any.missing = TRUE, all.missing = TRUE, len = NULL, min.len = NULL, max.len = NULL, unique = FALSE, names = NULL, info = NULL, label = NULL) {
  res = .Call("c_check_complex", x, any.missing, all.missing, len, min.len, max.len, unique, names, PACKAGE = "checkmate")
  makeExpectation(res, info = info, label = vname(x, label))
}
