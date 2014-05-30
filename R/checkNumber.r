#' Check if an argument is a single numeric
#'
#' @templateVar fn Number
#' @template na-handling
#' @template checker
#' @param na.ok [\code{logical(1)}]\cr
#'  Are missing values allowed? Default is \code{FALSE}.
#' @useDynLib checkmate c_check_number
#' @export
#' @examples
#'  testNumber(1)
#'  testNumber(1:2)
checkNumber = function(x, na.ok = FALSE) {
  .Call("c_check_number", x, na.ok, PACKAGE = "checkmate")
}

#' @rdname checkNumber
#' @export
assertNumber = function(x, na.ok = FALSE, .var.name) {
  makeAssertion(checkNumber(x, na.ok), vname(x, .var.name))
}

#' @rdname checkNumber
#' @export
testNumber = function(x, na.ok = FALSE) {
  isTRUE(checkNumber(x, na.ok))
}
