#' Check if an argument is a subset of a given set
#'
#' @templateVar fn Subset
#' @template x
#' @param choices [\code{atomic}]\cr
#'  Set of possible values.
#' @param empty.ok [\code{logical(1)}]\cr
#'  Treat zero-length \code{x} as subset of any set \code{choices}?
#'  Default is \code{TRUE}.
#' @template checker
#' @template null.ok
#' @family set
#' @export
#' @examples
#' testSubset(c("a", "z"), letters)
#' testSubset("ab", letters)
#' testSubset("Species", names(iris))
checkSubset = function(x, choices, empty.ok = TRUE, null.ok = FALSE) {
  if (is.null(x)) {
    if (identical(null.ok, TRUE))
      return(TRUE)
    return(sprintf("Must be a subset of {'%s'}, not 'NULL'", collapse(choices, "','")))
  }
  qassert(choices, "a+")
  qassert(empty.ok, "B1")
  if (!empty.ok && length(x) == 0L)
    return(sprintf("Must be a subset of {'%s'}, not empty", collapse(choices, "','")))
  if (any(x %nin% choices))
    return(sprintf("Must be a subset of {'%s'}", collapse(choices, "','")))
  return(TRUE)
}

#' @export
#' @include makeAssertion.r
#' @template assert
#' @rdname checkSubset
assertSubset = makeAssertionFunction(checkSubset)

#' @export
#' @rdname checkSubset
assert_subset = assertSubset

#' @export
#' @include makeTest.r
#' @rdname checkSubset
testSubset = makeTestFunction(checkSubset)

#' @export
#' @rdname checkSubset
test_subset = testSubset

#' @export
#' @include makeExpectation.r
#' @template expect
#' @rdname checkSubset
expect_subset = makeExpectationFunction(checkSubset)
