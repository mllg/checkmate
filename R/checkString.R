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
#' @inheritParams checkCharacter
#' @template checker
#' @family scalars
#' @export
#' @useDynLib checkmate c_check_string
#' @examples
#' testString("a")
#' testString(letters)
checkString = function(x, na.ok = FALSE, min.chars = NULL, pattern = NULL, fixed = NULL, ignore.case = FALSE) {
  .Call(c_check_string, x, na.ok, min.chars) %and%
  checkCharacterPattern(x, pattern, fixed, ignore.case)
}

#' @export
#' @include makeAssertion.R
#' @template assert
#' @rdname checkString
assertString = makeAssertionFunction(checkString)

#' @export
#' @rdname checkString
assert_string = assertString

#' @export
#' @include makeTest.R
#' @rdname checkString
testString = makeTestFunction(checkString)

#' @export
#' @rdname checkString
test_string = testString

#' @export
#' @include makeExpectation.R
#' @template expect
#' @rdname checkString
expect_string = makeExpectationFunction(checkString)
