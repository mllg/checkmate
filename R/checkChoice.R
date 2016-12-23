#' Check if an object is an element of a given set
#'
#' @templateVar fn Choice
#' @template x
#' @param choices [\code{atomic}]\cr
#'  Set of possible values.
#' @template null.ok
#' @template checker
#' @template set
#' @family set
#' @export
#' @examples
#' testChoice("x", letters)
#'
#' # x is not converted before the comparison (except for numerics)
#' testChoice(factor("a"), "a")
#' testChoice(1, "1")
#' testChoice(1, as.integer(1))
checkChoice = function(x, choices, null.ok = FALSE) {
  qassert(choices, "a")
  qassert(null.ok, "B1")
  if (is.null(x)) {
    if (null.ok)
      return(TRUE)
    return(sprintf("Must be a subset of {'%s'}, not 'NULL'", paste0(choices, collapse = "','")))
  }
  if (!qtest(x, "a1"))
    return(sprintf("Must be element of set {'%s'}, but is not atomic scalar", paste0(unique(choices), collapse = "','")))
  if (!isSameType(x, choices))
    return(sprintf("Must be element of set {'%s'}, but types do not match (%s != %s)", paste0(unique(choices), collapse = "','"), class(x)[1L], class(choices)[1L]))
  if (x %nin% choices)
    return(sprintf("Must be element of set {'%s'}, but is '%s'", paste0(unique(choices), collapse = "','"), x))
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
