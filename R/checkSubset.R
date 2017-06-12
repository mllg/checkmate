#' Check if an argument is a subset of a given set
#'
#' @templateVar fn Subset
#' @template x
#' @param choices [\code{atomic}]\cr
#'  Set of possible values. May be empty.
#' @param empty.ok [\code{logical(1)}]\cr
#'  Treat zero-length \code{x} as subset of any set \code{choices} (this includes \code{NULL})?
#'  Default is \code{TRUE}.
#' @template checker
#' @template set
#' @family set
#' @export
#' @examples
#' testSubset(c("a", "z"), letters)
#' testSubset("ab", letters)
#' testSubset("Species", names(iris))
#'
#' # x is not converted before the comparison (except for numerics)
#' testSubset(factor("a"), "a")
#' testSubset(1, "1")
#' testSubset(1, as.integer(1))
checkSubset = function(x, choices, empty.ok = TRUE) {
  qassert(choices, "a")
  qassert(empty.ok, "B1")
  if (!empty.ok && length(x) == 0L)
    return(sprintf("Must be a subset of {'%s'}, not empty", paste0(choices, collapse = "','")))
  if (length(choices) == 0L) {
    if (length(x) == 0L)
      return(TRUE)
    return("Must be a subset of the empty set, i.e. also empty")
  }
  if (!is.null(x) && (!isSameType(x, choices) || any(x %nin% choices)))
    return(sprintf("Must be a subset of {'%s'}", paste0(choices, collapse = "','")))
  return(TRUE)
}

#' @export
#' @rdname checkSubset
check_subset = checkSubset

#' @export
#' @include makeAssertion.R
#' @template assert
#' @rdname checkSubset
assertSubset = makeAssertionFunction(checkSubset)

#' @export
#' @rdname checkSubset
assert_subset = assertSubset

#' @export
#' @include makeTest.R
#' @rdname checkSubset
testSubset = makeTestFunction(checkSubset)

#' @export
#' @rdname checkSubset
test_subset = testSubset

#' @export
#' @include makeExpectation.R
#' @template expect
#' @rdname checkSubset
expect_subset = makeExpectationFunction(checkSubset)
