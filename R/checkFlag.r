#' Check if an argument is a flag
#'
#' A flag a a single logical value.
#'
#' @templateVar fn Flag
#' @template na-handling
#' @template checker
#' @param na.ok [\code{logical(1)}]\cr
#'  Are missing values allowed? Default is \code{FALSE}.
#' @useDynLib checkmate c_check_flag
#' @export
#' @examples
#'  testFlag(TRUE)
#'  testFlag(1)
checkFlag = function(x, na.ok = FALSE) {
  .Call("c_check_flag", x, na.ok, PACKAGE = "checkmate", .PACKAGE = "checkmate")
}

#' @rdname checkFlag
#' @export
assertFlag = function(x, na.ok = FALSE, .var.name) {
  makeAssertion(checkFlag(x, na.ok), vname(x, .var.name))
}

#' @rdname checkFlag
#' @export
testFlag = function(x, na.ok = FALSE) {
  isTRUE(checkFlag(x, na.ok))
}
