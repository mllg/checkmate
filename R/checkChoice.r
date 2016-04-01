#' Check if an object is an element of a given set
#'
#' @templateVar fn Choice
#' @template x
#' @param choices [\code{atomic}]\cr
#'  Set of possible values.
#' @template checker
#' @template null.ok
#' @family set
#' @export
#' @examples
#' testChoice("x", letters)
checkChoice = function(x, choices, null.ok = FALSE) {
  qassert(choices, "a")
  if (identical(null.ok, TRUE) && is.null(x))
    return(TRUE)
  if (!qtest(x, "a1") || x %nin% choices)
    return(sprintf("Must be element of set {'%s'}", collapse(unique(choices), "','")))
  return(TRUE)
}

#' @export
#' @include makeAssertion.r
#' @template assert
#' @rdname checkChoice
assertChoice = makeAssertionFunction(checkChoice)

#' @export
#' @rdname checkChoice
assert_choice = assertChoice

#' @export
#' @include makeTest.r
#' @rdname checkChoice
testChoice = makeTestFunction(checkChoice)

#' @export
#' @rdname checkChoice
test_choice = testChoice

#' @export
#' @include makeExpectation.r
#' @template expect
#' @rdname checkChoice
expect_choice = makeExpectationFunction(checkChoice)
