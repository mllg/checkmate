#' Check if an argument is a string
#'
#' @description
#' A string is defined as a scalar character vector.
#'
#' @templateVar fn String
#' @template x
#' @template na-handling
#' @param na.ok [\code{logical(1)}]\cr
#'  Are missing values allowed? Default is \code{FALSE}.
#' @param empty.ok [\code{logical(1)}]\cr
#'  Are empty strings allowed? Default is \code{TRUE}.
#' @template checker
#' @family scalars
#' @export
#' @useDynLib checkmate c_check_string
#' @examples
#' testString("a")
#' testString(letters)
checkString = function(x, na.ok = FALSE, empty.ok = TRUE) {
  .Call(c_check_string, x, na.ok, empty.ok)
}

#' @export
#' @include makeAssertion.r
#' @template assert
#' @rdname checkString
assertString = makeAssertionFunction(checkString, c.fun = "c_check_string")

#' @export
#' @rdname checkString
assert_string = assertString

#' @export
#' @include makeTest.r
#' @rdname checkString
testString = makeTestFunction(checkString, c.fun = "c_check_string")

#' @export
#' @rdname checkString
test_string = testString

#' @export
#' @include makeExpectation.r
#' @template expect
#' @rdname checkString
expect_string = makeExpectationFunction(checkString, c.fun = "c_check_string")
