#' Check if an argument is a single integer
#'
#' @templateVar fn Int
#' @template na-handling
#' @template checker
#' @param na.ok [\code{logical(1)}]\cr
#'  Are missing values allowed? Default is \code{FALSE}.
#' @param lower [\code{numeric(1)}]\cr
#'  Lower value all elements of \code{x} must be greater than.
#' @param upper [\code{numeric(1)}]\cr
#'  Upper value all elements of \code{x} must be lower than.
#' @family scalars
#' @useDynLib checkmate c_check_int
#' @export
#' @examples
#'  testInt(1)
#'  testInt(-1, lower = 0)
checkInt = function(x, na.ok = FALSE, lower = -Inf, upper = Inf) {
  .Call("c_check_int", x, na.ok, lower, upper, PACKAGE = "checkmate")
}

#' @rdname checkInt
#' @export
assertInt = function(x, na.ok = FALSE, lower = -Inf, upper = Inf, .var.name) {
  makeAssertion(
    .Call("c_check_int", x, na.ok, lower, upper, PACKAGE = "checkmate")
  , vname(x, .var.name))
}

#' @rdname checkInt
#' @export
testInt = function(x, na.ok = FALSE, lower = -Inf, upper = Inf) {
  isTRUE(
    .Call("c_check_int", x, na.ok, lower, upper, PACKAGE = "checkmate")
  )
}
