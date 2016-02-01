#' Check if an argument is a count
#'
#' @description
#' A count is defined as non-negative integerish value.
#'
#' @templateVar fn Count
#' @template x
#' @template na-handling
#' @param na.ok [\code{logical(1)}]\cr
#'  Are missing values allowed? Default is \code{FALSE}.
#' @param positive [\code{logical(1)}]\cr
#'  Must \code{x} be positive (>= 1)?
#'  Default is \code{FALSE}, allowing 0.
#' @template tol
#' @template checker
#' @family scalars
#' @useDynLib checkmate c_check_count
#' @export
#' @examples
#' testCount(1)
#' testCount(-1)
checkCount = function(x, na.ok = FALSE, positive = FALSE, tol = sqrt(.Machine$double.eps)) {
  .Call(c_check_count, x, na.ok, positive, tol)
}

#' @export
#' @include makeAssertion.r
#' @template assert
#' @rdname checkCount
assertCount = makeAssertionFunction(checkCount, c.fun = "c_check_count")

#' @export
#' @rdname checkCount
assert_count = assertCount

#' @export
#' @include makeTest.r
#' @rdname checkCount
testCount = makeTestFunction(checkCount, c.fun = "c_check_count")

#' @export
#' @rdname checkCount
test_count = testCount

#' @export
#' @include makeExpectation.r
#' @template expect
#' @rdname checkCount
expect_count = makeExpectationFunction(checkCount, c.fun = "c_check_count")
