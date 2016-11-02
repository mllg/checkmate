#' Check if an object is an element of a given set
#'
#' @templateVar fn Choice
#' @template x
#' @param choices [\code{atomic}]\cr
#'  Set of possible values.
#' @template checker
#' @template set
#' @family set
#' @export
#' @examples
#' testChoice("x", letters)
#'
#' # x is converted before the comparison if necessary
#' # note that this is subject to change in a future version
#' testChoice(factor("a"), "a")
#' testChoice(1, "1")
#' testChoice(1, as.integer(1))
checkChoice = function(x, choices) {
  qassert(choices, "a")
  if (!qtest(x, "a1") || x %nin% choices)
    return(sprintf("Must be element of set {'%s'}", paste0(unique(choices), collapse = "','")))
  return(TRUE)
}

#' @export
#' @rdname checkChoice
check_choice = checkChoice

#' @export
#' @include makeAssertion.R
#' @template assert
#' @rdname checkChoice
assertChoice = makeAssertionFunction(checkChoice)

#' @export
#' @rdname checkChoice
assert_choice = assertChoice

#' @export
#' @include makeTest.R
#' @rdname checkChoice
testChoice = makeTestFunction(checkChoice)

#' @export
#' @rdname checkChoice
test_choice = testChoice

#' @export
#' @include makeExpectation.R
#' @template expect
#' @rdname checkChoice
expect_choice = makeExpectationFunction(checkChoice)
