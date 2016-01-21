#' Check if an argument is a single numeric
#'
#' @templateVar fn Number
#' @template x
#' @template na-handling
#' @param na.ok [\code{logical(1)}]\cr
#'  Are missing values allowed? Default is \code{FALSE}.
#' @template bounds
#' @param finite [\code{logical(1)}]\cr
#'  Check for only finite values? Default is \code{FALSE}.
#' @template checker
#' @family scalars
#' @useDynLib checkmate c_check_number
#' @export
#' @examples
#' testNumber(1)
#' testNumber(1:2)
checkNumber = function(x, na.ok = FALSE, lower = -Inf, upper = Inf, finite = FALSE) {
  .Call(c_check_number, x, na.ok, lower, upper, finite)
}

#' @export
#' @include makeAssertion.r
#' @template assert
#' @rdname checkNumber
assertNumber = makeAssertionFunction(checkNumber)

#' @export
#' @rdname checkNumber
assert_number = assertNumber

#' @export
#' @include makeTest.r
#' @rdname checkNumber
testNumber = makeTestFunction(checkNumber)

#' @export
#' @rdname checkNumber
test_number = testNumber

#' @export
#' @include makeExpectation.r
#' @template expect
#' @rdname checkNumber
expect_number = makeExpectationFunction(checkNumber)
