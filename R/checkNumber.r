#' Check if an argument is a single numeric
#'
#' @templateVar fn Number
#' @template na-handling
#' @template checker
#' @param na.ok [\code{logical(1)}]\cr
#'  Are missing values allowed? Default is \code{FALSE}.
#' @template bounds
#' @param finite [\code{logical(1)}]\cr
#'  Check for only finite values? Default is \code{FALSE}.
#' @family scalars
#' @useDynLib checkmate c_check_number
#' @export
#' @examples
#'  testNumber(1)
#'  testNumber(1:2)
checkNumber = function(x, na.ok = FALSE, lower = -Inf, upper = Inf, finite = FALSE) {
  .Call("c_check_number", x, na.ok, lower, upper, finite, PACKAGE = "checkmate")
}

#' @rdname checkNumber
#' @export
assertNumber = function(x, na.ok = FALSE, lower = -Inf, upper = Inf, finite = FALSE, .var.name) {
  makeAssertion(
    .Call("c_check_number", x, na.ok, lower, upper, finite, PACKAGE = "checkmate")
  , vname(x, .var.name))
}

#' @rdname checkNumber
#' @export
testNumber = function(x, na.ok = FALSE, lower = -Inf, upper = Inf, finite = FALSE) {
  isTRUE(
    .Call("c_check_number", x, na.ok, lower, upper, finite, PACKAGE = "checkmate")
  )
}
