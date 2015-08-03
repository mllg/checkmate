#' Check if an argument is a single missing value
#'
#' @templateVar fn ScalarNA
#' @template x
#' @template checker
#' @family scalars
#' @export
#' @examples
#' testScalarNA(1)
#' testScalarNA(NA_real_)
#' testScalarNA(rep(NA, 2))
checkScalarNA = function(x) {
  if (length(x) != 1L || !is.na(x))
    return("Must be a scalar missing value")
  return(TRUE)
}

#' @rdname checkScalarNA
#' @export
assertScalarNA = function(x, add = NULL, .var.name) {
  res = checkScalarNA(x)
  makeAssertion(res, vname(x, .var.name), add)
}

#' @rdname checkScalarNA
#' @export
testScalarNA = function(x) {
  res = checkScalarNA(x)
  isTRUE(res)
}

#' @rdname checkScalarNA
#' @template expect
#' @export
expect_scalar_na = function(x, info = NULL, label = NULL) {
  res = checkScalarNA(x)
  makeExpectation(res, info = info, label = vname(x, label))
}
