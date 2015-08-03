#' Check if an argument is a single atomic value
#'
#' @templateVar fn Scalar
#' @template x
#' @template na-handling
#' @param na.ok [\code{logical(1)}]\cr
#'  Are missing values allowed? Default is \code{FALSE}.
#' @template checker
#' @family scalars
#' @useDynLib checkmate c_check_scalar
#' @export
#' @examples
#' testScalar(1)
#' testScalar(1:10)
checkScalar = function(x, na.ok = FALSE) {
  .Call("c_check_scalar", x, na.ok, PACKAGE = "checkmate")
}

#' @rdname checkScalar
#' @useDynLib checkmate c_check_scalar
#' @export
assertScalar = function(x, na.ok = FALSE, add = NULL, .var.name) {
  res = .Call("c_check_scalar", x, na.ok, PACKAGE = "checkmate")
  makeAssertion(res, vname(x, .var.name), add)
}

#' @rdname checkScalar
#' @useDynLib checkmate c_check_scalar
#' @export
testScalar = function(x, na.ok = FALSE) {
  res = .Call("c_check_scalar", x, na.ok, PACKAGE = "checkmate")
  isTRUE(res)
}

#' @rdname checkScalar
#' @template expect
#' @useDynLib checkmate c_check_scalar
#' @export
expect_scalar = function(x, na.ok = FALSE, info = NULL, label = NULL) {
  res = .Call("c_check_scalar", x, na.ok, PACKAGE = "checkmate")
  makeExpectation(res, info = info, label = vname(x, label))
}
