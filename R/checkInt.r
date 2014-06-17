#' Check if an argument is a single integerish value
#'
#' @templateVar fn Int
#' @template na-handling
#' @template checker
#' @param na.ok [\code{logical(1)}]\cr
#'  Are missing values allowed? Default is \code{FALSE}.
#' @template bounds
#' @template tol
#' @family scalars
#' @useDynLib checkmate c_check_int
#' @export
#' @examples
#'  testInt(1)
#'  testInt(-1, lower = 0)
checkInt = function(x, na.ok = FALSE, lower = -Inf, upper = Inf, tol = sqrt(.Machine$double.eps)) {
  .Call("c_check_int", x, na.ok, lower, upper, tol, PACKAGE = "checkmate")
}

#' @rdname checkInt
#' @export
assertInt = function(x, na.ok = FALSE, lower = -Inf, upper = Inf, tol = sqrt(.Machine$double.eps), .var.name) {
  makeAssertion(
    .Call("c_check_int", x, na.ok, lower, upper, tol, PACKAGE = "checkmate")
  , vname(x, .var.name))
}

#' @rdname checkInt
#' @export
testInt = function(x, na.ok = FALSE, lower = -Inf, upper = Inf, tol = sqrt(.Machine$double.eps)) {
  isTRUE(
    .Call("c_check_int", x, na.ok, lower, upper, tol, PACKAGE = "checkmate")
  )
}
