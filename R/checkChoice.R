#' Check if an object is an element of a given set
#'
#' @templateVar fn Choice
#' @template x
#' @param choices [\code{atomic}]\cr
#'  Set of possible values.
#' @template null.ok
#' @template fmatch
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
checkChoice = function(x, choices, null.ok = FALSE, fmatch = FALSE) {
  qassert(null.ok, "B1")

  if (is.null(x)) {
    if (null.ok)
      return(TRUE)
    qassert(choices, "a")
    return(sprintf("Must be a subset of %s, not 'NULL'", set_collapse(choices)))
  }

  qassert(choices, "a")
  if (!qtest(x, "a1"))
    return(sprintf("Must be element of set %s, but is not atomic scalar", set_collapse(choices)))
  if (!isSameType(x, choices))
    return(sprintf("Must be element of set %s, but types do not match (%s != %s)", set_collapse(choices), class(x)[1L], class(choices)[1L]))

  if (isTRUE(fmatch) && requireNamespace("fastmatch", quietly = TRUE))
    match = fastmatch::fmatch

  if (match(x, choices, 0L) == 0L)
    return(sprintf("Must be element of set %s, but is '%s'", set_collapse(choices), x))
  return(TRUE)
}

#' @export
#' @rdname checkChoice
check_choice = checkChoice

#' @export
#' @include makeAssertion.R
#' @template assert
#' @rdname checkChoice
assertChoice = makeAssertionFunction(checkChoice, use.namespace = FALSE)

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
expect_choice = makeExpectationFunction(checkChoice, use.namespace = FALSE)
