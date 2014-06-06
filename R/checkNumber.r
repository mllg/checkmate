#' Check if an argument is a single numeric
#'
#' @templateVar fn Number
#' @template na-handling
#' @template checker
#' @param na.ok [\code{logical(1)}]\cr
#'  Are missing values allowed? Default is \code{FALSE}.
#' @param lower [\code{numeric(1)}]\cr
#'  Lower value all elements of \code{x} must be greater than.
#' @param upper [\code{numeric(1)}]\cr
#'  Upper value all elements of \code{x} must be lower than.
#' @family scalars
#' @useDynLib checkmate c_check_number
#' @export
#' @examples
#'  testNumber(1)
#'  testNumber(1:2)
checkNumber = function(x, na.ok = FALSE, lower = -Inf, upper = Inf) {
  .Call("c_check_number", x, na.ok, lower, upper, PACKAGE = "checkmate")
}

#' @rdname checkNumber
#' @export
assertNumber = function(x, na.ok = FALSE, lower = -Inf, upper = Inf, .var.name) {
  makeAssertion(
    .Call("c_check_number", x, na.ok, lower, upper, PACKAGE = "checkmate")
  , vname(x, .var.name))
}

#' @rdname checkNumber
#' @export
testNumber = function(x, na.ok = FALSE, lower = -Inf, upper = Inf) {
  isTRUE(
    .Call("c_check_number", x, na.ok, lower, upper, PACKAGE = "checkmate")
  )
}
