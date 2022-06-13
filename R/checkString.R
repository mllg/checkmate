#' Check if an argument is a string
#'
#' @description
#' A string is defined as a scalar character vector.
#' To check for vectors of arbitrary length, see \code{\link{checkCharacter}}.
#'
#' @templateVar fn String
#' @template x
#' @template na-handling
#' @template na.ok
#' @inheritParams checkCharacter
#' @template null.ok
#' @template checker
#' @family scalars
#' @export
#' @useDynLib checkmate c_check_string
#' @examples
#' testString("a")
#' testString(letters)
checkString = function(x, na.ok = FALSE, n.chars = NULL, min.chars = NULL, max.chars = NULL, pattern = NULL, fixed = NULL, ignore.case = FALSE, null.ok = FALSE) {
  .Call(c_check_string, x, na.ok, n.chars, min.chars, max.chars, null.ok) %and%
  checkCharacterPattern(x, pattern, fixed, ignore.case)
}

#' @export
#' @rdname checkString
check_string = checkString

#' @export
#' @include makeAssertion.R
#' @template assert
#' @rdname checkString
assertString = makeAssertionFunction(checkString, use.namespace = FALSE)

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
expect_string = makeExpectationFunction(checkString, use.namespace = FALSE)
