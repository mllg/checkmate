#' Check if an argument is a string
#'
#' @description
#' A string is defined as a scalar character vector.
#'
#' @templateVar fn String
#' @template x
#' @template na-handling
#' @param na.ok [\code{logical(1)}]\cr
#'  Are missing values allowed? Default is \code{FALSE}.
#' @template checker
#' @family scalars
#' @export
#' @useDynLib checkmate c_check_string
#' @examples
#' testString("a")
#' testString(letters)
checkString = function(x, na.ok = FALSE) {
  .Call("c_check_string", x, na.ok, PACKAGE = "checkmate")
}

#' @rdname checkString
#' @useDynLib checkmate c_check_string
#' @export
assertString = function(x, na.ok = FALSE, .var.name) {
  res = checkString(x, na.ok)
  makeAssertion(res, vname(x, .var.name))
}

#' @rdname checkString
#' @useDynLib checkmate c_check_string
#' @export
testString = function(x, na.ok = FALSE) {
  res = checkString(x, na.ok)
  isTRUE(res)
}

#' @rdname checkString
#' @template expect
#' @useDynLib checkmate c_check_string
#' @export
expect_string = function(x, na.ok = FALSE, info = NULL, label = NULL) {
  res = checkString(x, na.ok)
  makeExpectation(res, info = info, label = vname(x, label))
}
