#' Check if an argument is a single integerish value
#'
#' @templateVar fn Int
#' @template x
#' @template na-handling
#' @param na.ok [\code{logical(1)}]\cr
#'  Are missing values allowed? Default is \code{FALSE}.
#' @template bounds
#' @template tol
#' @template checker
#' @family scalars
#' @useDynLib checkmate c_check_int
#' @export
#' @examples
#' testInt(1)
#' testInt(-1, lower = 0)
checkInt = function(x, na.ok = FALSE, lower = -Inf, upper = Inf, tol = sqrt(.Machine$double.eps)) {
  .Call("c_check_int", x, na.ok, lower, upper, tol, PACKAGE = "checkmate")
}

#' @rdname checkInt
#' @useDynLib checkmate c_check_int
#' @export
assertInt = function(x, na.ok = FALSE, lower = -Inf, upper = Inf, tol = sqrt(.Machine$double.eps), add = NULL, .var.name) {
  res = .Call("c_check_int", x, na.ok, lower, upper, tol, PACKAGE = "checkmate")
  makeAssertion(res, vname(x, .var.name), add)
}

#' @rdname checkInt
#' @useDynLib checkmate c_check_int
#' @export
testInt = function(x, na.ok = FALSE, lower = -Inf, upper = Inf, tol = sqrt(.Machine$double.eps)) {
  res = .Call("c_check_int", x, na.ok, lower, upper, tol, PACKAGE = "checkmate")
  isTRUE(res)
}

#' @rdname checkInt
#' @template expect
#' @useDynLib checkmate c_check_int
#' @export
expect_int = function(x, na.ok = FALSE, lower = -Inf, upper = Inf, tol = sqrt(.Machine$double.eps), info = NULL, label = NULL) {
  res = .Call("c_check_int", x, na.ok, lower, upper, tol, PACKAGE = "checkmate")
  makeExpectation(res, info = info, label = vname(x, label))
}
