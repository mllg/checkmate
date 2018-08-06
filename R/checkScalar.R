#' Check if an argument is a single atomic value
#'
#' @templateVar fn Scalar
#' @template x
#' @template na-handling
#' @template na.ok
#' @template null.ok
#' @template checker
#' @family scalars
#' @useDynLib checkmate c_check_scalar
#' @export
#' @examples
#' testScalar(1)
#' testScalar(1:10)
checkScalar = function(x, na.ok = FALSE, null.ok = FALSE) {
  .Call(c_check_scalar, x, na.ok, null.ok)
}

#' @export
#' @rdname checkScalar
check_scalar = checkScalar

#' @export
#' @include makeAssertion.R
#' @template assert
#' @rdname checkScalar
assertScalar = makeAssertionFunction(checkScalar, c.fun = "c_check_scalar", use.namespace = FALSE)

#' @export
#' @rdname checkScalar
assert_scalar = assertScalar

#' @export
#' @include makeTest.R
#' @rdname checkScalar
testScalar = makeTestFunction(checkScalar, c.fun = "c_check_scalar")

#' @export
#' @rdname checkScalar
test_scalar = testScalar

#' @export
#' @include makeExpectation.R
#' @template expect
#' @rdname checkScalar
expect_scalar = makeExpectationFunction(checkScalar, c.fun = "c_check_scalar", use.namespace = FALSE)
