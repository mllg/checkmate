#' Check if an argument is a vector of type logical
#'
#' @templateVar fn Logical
#' @template x
#' @template na-handling
#' @inheritParams checkVector
#' @template checker
#' @family basetypes
#' @useDynLib checkmate c_check_logical
#' @export
#' @examples
#' testLogical(TRUE)
#' testLogical(TRUE, min.len = 1)
checkLogical = function(x, any.missing = TRUE, all.missing = TRUE, len = NULL, min.len = NULL, max.len = NULL, unique = FALSE, names = NULL) {
  .Call("c_check_logical", x, any.missing, all.missing, len, min.len, max.len, unique, names, PACKAGE = "checkmate")
}

#' @rdname checkLogical
#' @useDynLib checkmate c_check_logical
#' @export
assertLogical = function(x, any.missing = TRUE, all.missing = TRUE, len = NULL, min.len = NULL, max.len = NULL, unique = FALSE, names = NULL, .var.name) {
  res = .Call("c_check_logical", x, any.missing, all.missing, len, min.len, max.len, unique, names, PACKAGE = "checkmate")
  makeAssertion(res, vname(x, .var.name))
}

#' @rdname checkLogical
#' @useDynLib checkmate c_check_logical
#' @export
testLogical = function(x, any.missing = TRUE, all.missing = TRUE, len = NULL, min.len = NULL, max.len = NULL, unique = FALSE, names = NULL) {
  isTRUE(.Call("c_check_logical", x, any.missing, all.missing, len, min.len, max.len, unique, names, PACKAGE = "checkmate"))
}
