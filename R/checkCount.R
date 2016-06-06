#' Check if an argument is a count
#'
#' @description
#' A count is defined as non-negative integerish value.
#'
#' @templateVar fn Count
#' @template x
#' @template na-handling
#' @template na.ok
#' @param positive [\code{logical(1)}]\cr
#'  Must \code{x} be positive (>= 1)?
#'  Default is \code{FALSE}, allowing 0.
#' @template tol
#' @template null.ok
#' @template checker
#' @family scalars
#' @useDynLib checkmate c_check_count
#' @export
#' @examples
#' testCount(1)
#' testCount(-1)
checkCount = function(x, na.ok = FALSE, positive = FALSE, tol = sqrt(.Machine$double.eps), null.ok = FALSE) {
  .Call(c_check_count, x, na.ok, positive, tol, null.ok)
}

#' @export
#' @rdname checkCount
check_count = checkCount

#' @export
#' @include makeAssertion.R
#' @template assert
#' @rdname checkCount
assertCount = makeAssertionFunction(checkCount, c.fun = "c_check_count")

#' @export
#' @rdname checkCount
assert_count = assertCount

#' @export
#' @include makeTest.R
#' @rdname checkCount
testCount = makeTestFunction(checkCount, c.fun = "c_check_count")

#' @export
#' @rdname checkCount
test_count = testCount

#' @export
#' @include makeExpectation.R
#' @template expect
#' @rdname checkCount
expect_count = makeExpectationFunction(checkCount, c.fun = "c_check_count")
