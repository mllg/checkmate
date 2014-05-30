#' Check if an argument is a count
#'
#' A count is a non-negative integer.
#'
#' @templateVar fn Count
#' @template na-handling
#' @template checker
#' @param na.ok [\code{logical(1)}]\cr
#'  Are missing values allowed? Default is \code{FALSE}.
#' @param positive [\code{logical(1)}]\cr
#'  Must \code{x} be positive (> 0)?
#'  Default is \code{FALSE}.
#' @useDynLib checkmate c_check_count
#' @export
#' @examples
#'  testCount(1)
#'  testCount(-1)
checkCount = function(x, na.ok = FALSE, positive = FALSE) {
  .Call("c_check_count", x, na.ok, positive, PACKAGE = "checkmate")
}

#' @rdname checkCount
#' @export
assertCount = function(x, na.ok = FALSE, positive = FALSE, .var.name) {
  makeAssertion(
    .Call("c_check_count", x, na.ok, positive, PACKAGE = "checkmate")
  , vname(x, .var.name))
}

#' @rdname checkCount
#' @export
testCount = function(x, na.ok = FALSE, positive = FALSE) {
  isTRUE(
    .Call("c_check_count", x, na.ok, positive, PACKAGE = "checkmate")
  )
}
