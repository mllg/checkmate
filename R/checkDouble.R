#' Check that an argument is a vector of type double
#'
#' @templateVar fn Double
#' @template x
#' @template na-handling
#' @inheritParams checkVector
#' @template bounds
#' @template sorted
#' @param finite [\code{logical(1)}]\cr
#'  Check for only finite values? Default is \code{FALSE}.
#' @template null.ok
#' @template checker
#' @family basetypes
#' @useDynLib checkmate c_check_double
#' @export
#' @examples
#' testDouble(1)
#' testDouble(1L)
#' testDouble(1, min.len = 1, lower = 0)
checkDouble = function(x, lower = -Inf, upper = Inf, finite = FALSE, any.missing = TRUE, all.missing = TRUE, len = NULL, min.len = NULL, max.len = NULL, unique = FALSE, sorted = FALSE, names = NULL, null.ok = FALSE) {
  .Call(c_check_double, x, lower, upper, finite, any.missing, all.missing, len, min.len, max.len, unique, sorted, names, null.ok)
}

#' @export
#' @rdname checkDouble
check_double = checkDouble

#' @export
#' @include makeAssertion.R
#' @template assert
#' @rdname checkDouble
assertDouble = makeAssertionFunction(checkDouble, c.fun = "c_check_double", use.namespace = FALSE)

#' @export
#' @rdname checkDouble
assert_double = assertDouble

#' @export
#' @include makeTest.R
#' @rdname checkDouble
testDouble = makeTestFunction(checkDouble, c.fun = "c_check_double")

#' @export
#' @rdname checkDouble
test_double = testDouble

#' @export
#' @include makeExpectation.R
#' @template expect
#' @rdname checkDouble
expect_double = makeExpectationFunction(checkDouble, c.fun = "c_check_double", use.namespace = FALSE)
