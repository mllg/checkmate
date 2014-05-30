#' Check that an argument is a vector of type numeric
#'
#' @templateVar fn Numeric
#' @template na-handling
#' @template checker
#' @inheritParams checkVector
#' @param lower [\code{numeric(1)}]\cr
#'  Lower value all elements of \code{x} must be greater than.
#' @param upper [\code{numeric(1)}]\cr
#'  Upper value all elements of \code{x} must be lower than.
#' @family basetypes
#' @useDynLib checkmate c_check_numeric
#' @export
#' @examples
#'  testNumeric(1)
#'  testNumeric(1, min.len = 1, lower = 0)
checkNumeric = function(x, lower = -Inf, upper = Inf, any.missing = TRUE, all.missing = TRUE, len = NULL, min.len = NULL, max.len = NULL, unique = FALSE, names = NULL) {
  .Call("c_check_numeric", x, lower, upper, any.missing, all.missing, len, min.len, max.len, unique, names, PACKAGE = "checkmate")
}

#' @rdname checkNumeric
#' @useDynLib checkmate c_check_numeric
#' @export
assertNumeric = function(x, lower = -Inf, upper = Inf, any.missing = TRUE, all.missing = TRUE, len = NULL, min.len = NULL, max.len = NULL, unique = FALSE, names = NULL, .var.name) {
  makeAssertion(
    .Call("c_check_numeric", x, lower, upper, any.missing, all.missing, len, min.len, max.len, unique, names, PACKAGE = "checkmate")
  , vname(x, .var.name))
}

#' @rdname checkNumeric
#' @useDynLib checkmate c_check_numeric
#' @export
testNumeric = function(x, lower = -Inf, upper = Inf, any.missing = TRUE, all.missing = TRUE, len = NULL, min.len = NULL, max.len = NULL, unique = FALSE, names = NULL) {
  isTRUE(
    .Call("c_check_numeric", x, lower, upper, any.missing, all.missing, len, min.len, max.len, unique, names, PACKAGE = "checkmate")
  )
}
