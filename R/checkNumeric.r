#' Check that an argument is a vector of type numeric
#'
#' @templateVar fn Numeric
#' @template na-handling
#' @template checker
#' @inheritParams checkVector
#' @template bounds
#' @param finite [\code{logical(1)}]\cr
#'  Check for only finite values? Default is \code{FALSE}.
#' @family basetypes
#' @useDynLib checkmate c_check_numeric
#' @export
#' @examples
#'  testNumeric(1)
#'  testNumeric(1, min.len = 1, lower = 0)
checkNumeric = function(x, lower = -Inf, upper = Inf, finite = FALSE, any.missing = TRUE, all.missing = TRUE, len = NULL, min.len = NULL, max.len = NULL, unique = FALSE, names = NULL) {
  .Call("c_check_numeric", x, lower, upper, finite, any.missing, all.missing, len, min.len, max.len, unique, names, PACKAGE = "checkmate")
}

#' @rdname checkNumeric
#' @useDynLib checkmate c_check_numeric
#' @export
assertNumeric = function(x, lower = -Inf, upper = Inf, finite = FALSE, any.missing = TRUE, all.missing = TRUE, len = NULL, min.len = NULL, max.len = NULL, unique = FALSE, names = NULL, .var.name) {
  res = .Call("c_check_numeric", x, lower, upper, finite, any.missing, all.missing, len, min.len, max.len, unique, names, PACKAGE = "checkmate")
  makeAssertion(res, vname(x, .var.name))
}

#' @rdname checkNumeric
#' @useDynLib checkmate c_check_numeric
#' @export
testNumeric = function(x, lower = -Inf, upper = Inf, finite = FALSE, any.missing = TRUE, all.missing = TRUE, len = NULL, min.len = NULL, max.len = NULL, unique = FALSE, names = NULL) {
  isTRUE(.Call("c_check_numeric", x, lower, upper, finite, any.missing, all.missing, len, min.len, max.len, unique, names, PACKAGE = "checkmate"))
}
