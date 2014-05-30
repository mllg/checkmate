#' Check if an argument is a count
#'
#' A count is a non-negative integer.
#'
#' @templateVar fn Count
#' @template na-handling
#' @template checker
#' @param na.ok [\code{logical(1)}]\cr
#'  Are missing values allowed? Default is \code{FALSE}.
#' @useDynLib checkmate c_check_count
#' @export
#' @examples
#'  testCount(1)
#'  testCount(-1)
checkCount = function(x, na.ok = FALSE) {
  .Call("c_check_count", x, na.ok, PACKAGE = "checkmate")
}

#' @rdname checkCount
#' @export
assertCount = function(x, na.ok = FALSE, .var.name) {
  makeAssertion(checkCount(x, na.ok), vname(x, .var.name))
}

#' @rdname checkCount
#' @export
testCount = function(x, na.ok = FALSE) {
  isTRUE(checkCount(x, na.ok))
}
