#' Check that an argument is a vector of type numeric
#'
#' @templateVar fn Numeric
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
#' @useDynLib checkmate c_check_numeric
#' @export
#' @examples
#' testNumeric(1)
#' testNumeric(1, min.len = 1, lower = 0)
checkNumeric = function(x, lower = -Inf, upper = Inf, finite = FALSE, any.missing = TRUE, all.missing = TRUE, len = NULL, min.len = NULL, max.len = NULL, unique = FALSE, sorted = FALSE, names = NULL, null.ok = FALSE) {
  .Call(c_check_numeric, x, lower, upper, finite, any.missing, all.missing, len, min.len, max.len, unique, sorted, names, null.ok)
}

#' @export
#' @rdname checkNumeric
check_numeric = checkNumeric

#' @export
#' @include makeAssertion.R
#' @template assert
#' @rdname checkNumeric
assertNumeric = makeAssertionFunction(checkNumeric, c.fun = "c_check_numeric")

#' @export
#' @rdname checkNumeric
assert_numeric = assertNumeric

#' @export
#' @include makeTest.R
#' @rdname checkNumeric
testNumeric = makeTestFunction(checkNumeric, c.fun = "c_check_numeric")

#' @export
#' @rdname checkNumeric
test_numeric = testNumeric

#' @export
#' @include makeExpectation.R
#' @template expect
#' @rdname checkNumeric
expect_numeric = makeExpectationFunction(checkNumeric, c.fun = "c_check_numeric")
