#' Check if an argument is a subset of a given set
#'
#' @templateVar fn Subset
#' @template x
#' @param choices [\code{atomic}]\cr
#'  Set of possible values. May be empty.
#' @param empty.ok [\code{logical(1)}]\cr
#'  Treat zero-length \code{x} as subset of any set \code{choices} (this includes \code{NULL})?
#'  Default is \code{TRUE}.
#' @template fmatch
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
checkSubset = function(x, choices, empty.ok = TRUE, fmatch = FALSE) {
  qassert(empty.ok, "B1")
  if (length(x) == 0L) {
    if (!empty.ok)
      return(sprintf("Must be a subset of %s, not empty", set_collapse(choices)))
    return(TRUE)
  }

  qassert(choices, "a")
  if (length(choices) == 0L) {
    if (length(x) == 0L)
      return(TRUE)
    return("Must be a subset of the empty set, i.e. also empty")
  }

  if (isTRUE(fmatch) && requireNamespace("fastmatch", quietly = TRUE))
    match = fastmatch::fmatch

  if (!is.null(x) && (!isSameType(x, choices) || anyMissing(match(x, choices))))
    return(sprintf("Must be a subset of %s, but is %s", set_collapse(choices), set_collapse(x)))
  return(TRUE)
}

#' @export
#' @rdname checkSubset
check_subset = checkSubset

#' @export
#' @include makeAssertion.R
#' @template assert
#' @rdname checkSubset
assertSubset = makeAssertionFunction(checkSubset, use.namespace = FALSE)

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
expect_subset = makeExpectationFunction(checkSubset, use.namespace = FALSE)
