#' Check if an argument is a single integerish value
#'
#' @templateVar fn Int
#' @template x
#' @template na-handling
#' @template na.ok
#' @template bounds
#' @template tol
#' @template null.ok
#' @template checker
#' @family scalars
#' @useDynLib checkmate c_check_int
#' @export
#' @examples
#' testInt(1)
#' testInt(-1, lower = 0)
checkInt = function(x, na.ok = FALSE, lower = -Inf, upper = Inf, tol = sqrt(.Machine$double.eps), null.ok = FALSE) {
  .Call(c_check_int, x, na.ok, lower, upper, tol, null.ok)
}

#' @export
#' @rdname checkInt
check_int = checkInt

#' @export
#' @include makeAssertion.R
#' @template assert
#' @rdname checkInt
assertInt = makeAssertionFunction(checkInt, c.fun = "c_check_int")

#' @export
#' @rdname checkInt
assert_int = assertInt

#' @export
#' @include makeTest.R
#' @rdname checkInt
testInt = makeTestFunction(checkInt, c.fun = "c_check_int")

#' @export
#' @rdname checkInt
test_int = testInt

#' @export
#' @include makeExpectation.R
#' @template expect
#' @rdname checkInt
expect_int = makeExpectationFunction(checkInt, c.fun = "c_check_int")
