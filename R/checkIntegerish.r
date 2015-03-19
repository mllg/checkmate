#' Check if an object is an integerish vector
#'
#' @templateVar fn Integerish
#' @template x
#' @template na-handling
#' @inheritParams checkInteger
#' @inheritParams checkVector
#' @template tol
#' @template checker
#' @family basetypes
#' @useDynLib checkmate c_is_integerish
#' @export
#' @examples
#' testIntegerish(1L)
#' testIntegerish(1.)
#' testIntegerish(1:2, lower = 1L, upper = 2L, any.missing = FALSE)
checkIntegerish = function(x, tol = sqrt(.Machine$double.eps), lower = -Inf, upper = Inf, any.missing = TRUE, all.missing = TRUE, len = NULL, min.len = NULL, max.len = NULL, unique = FALSE, names = NULL) {
  .Call("c_check_integerish", x, tol, lower, upper, any.missing, all.missing, len, min.len, max.len, unique, names, PACKAGE = "checkmate")
}

#' @rdname checkIntegerish
#' @useDynLib checkmate c_is_integerish
#' @export
assertIntegerish = function(x, tol = sqrt(.Machine$double.eps), lower = -Inf, upper = Inf, any.missing = TRUE, all.missing = TRUE, len = NULL, min.len = NULL, max.len = NULL, unique = FALSE, names = NULL, .var.name) {
  res = .Call("c_check_integerish", x, tol, lower, upper, any.missing, all.missing, len, min.len, max.len, unique, names, PACKAGE = "checkmate")
  makeAssertion(res, vname(x, .var.name))
}

#' @rdname checkIntegerish
#' @useDynLib checkmate c_is_integerish
#' @export
testIntegerish = function(x, tol = sqrt(.Machine$double.eps), lower = -Inf, upper = Inf, any.missing = TRUE, all.missing = TRUE, len = NULL, min.len = NULL, max.len = NULL, unique = FALSE, names = NULL) {
  res = .Call("c_check_integerish", x, tol, lower, upper, any.missing, all.missing, len, min.len, max.len, unique, names, PACKAGE = "checkmate")
  isTRUE(res)
}
