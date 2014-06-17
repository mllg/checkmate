#' Check that an argument is an atomic vector
#'
#' @templateVar fn Atmoic
#' @template checker
#' @inheritParams checkVector
#' @family basetypes
#' @useDynLib checkmate c_check_atomic
#' @export
#' @examples
#'  testAtomic(letters, min.len = 1L, any.missing = FALSE)
checkAtomic = function(x, any.missing = TRUE, all.missing = TRUE, len = NULL, min.len = NULL, max.len = NULL, unique = FALSE, names = NULL) {
  .Call("c_check_atomic", x, any.missing, all.missing, len, min.len, max.len, unique, names, PACKAGE = "checkmate")
}

#' @rdname checkAtomic
#' @useDynLib checkmate c_check_atomic
#' @export
assertAtomic = function(x, any.missing = TRUE, all.missing = TRUE, len = NULL, min.len = NULL, max.len = NULL, unique = FALSE, names = NULL, .var.name) {
  res = .Call("c_check_atomic", x, any.missing, all.missing, len, min.len, max.len, unique, names, PACKAGE = "checkmate")
  makeAssertion(res, vname(x, .var.name))
}

#' @rdname checkAtomic
#' @useDynLib checkmate c_check_atomic
#' @export
testAtomic = function(x, any.missing = TRUE, all.missing = TRUE, len = NULL, min.len = NULL, max.len = NULL, unique = FALSE, names = NULL) {
  isTRUE(
    .Call("c_check_atomic", x, any.missing, all.missing, len, min.len, max.len, unique, names, PACKAGE = "checkmate")
  )
}
