#' Check if an argument is a flag
#'
#' A flag a a single logical value.
#'
#' @templateVar fn Flag
#' @template na-handling
#' @template checker
#' @param na.ok [\code{logical(1)}]\cr
#'  Are missing values allowed? Default is \code{FALSE}.
#' @family scalars
#' @useDynLib checkmate c_check_flag
#' @export
#' @examples
#'  testFlag(TRUE)
#'  testFlag(1)
checkFlag = function(x, na.ok = FALSE) {
  .Call("c_check_flag", x, na.ok, PACKAGE = "checkmate")
}

#' @rdname checkFlag
#' @useDynLib checkmate c_check_flag
#' @export
assertFlag = function(x, na.ok = FALSE, .var.name) {
  res = .Call("c_check_flag", x, na.ok, PACKAGE = "checkmate")
  makeAssertion(res, vname(x, .var.name))
}

#' @rdname checkFlag
#' @useDynLib checkmate c_check_flag
#' @export
testFlag = function(x, na.ok = FALSE) {
  isTRUE(
    .Call("c_check_flag", x, na.ok, PACKAGE = "checkmate")
  )
}
