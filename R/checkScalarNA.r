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

#' @export
#' @include makeAssertion.r
#' @template assert
#' @rdname checkScalarNA
assertScalarNA = makeAssertionFunction(checkScalarNA)

#' @export
#' @rdname checkScalarNA
assert_scalar_na = assertScalarNA

#' @export
#' @include makeTest.r
#' @rdname checkScalarNA
testScalarNA = makeTestFunction(checkScalarNA)

#' @export
#' @rdname checkScalarNA
test_scalar_na = testScalarNA

#' @export
#' @include makeExpectation.r
#' @template expect
#' @rdname checkScalarNA
expect_scalar_na = makeExpectationFunction(checkScalarNA)
