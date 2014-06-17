#' Check if an argument is a single missing value
#'
#' @templateVar fn ScalarNA
#' @template checker
#' @family scalars
#' @export
#' @examples
#'  testScalarNA(1)
#'  testScalarNA(NA_real_)
#'  testScalarNA(rep(NA, 2))
checkScalarNA = function(x) {
  if (length(x) != 1L || !is.na(x))
    return("Must be a scalar missing value")
  return(TRUE)
}

#' @rdname checkScalarNA
#' @export
assertScalarNA = function(x, .var.name) {
  makeAssertion(
    checkScalarNA(x)
  , vname(x, .var.name))
}

#' @rdname checkScalarNA
#' @export
testScalarNA = function(x) {
  isTRUE(
    checkScalarNA(x)
  )
}
