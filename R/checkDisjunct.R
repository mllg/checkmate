#' Check if an argument is disjunct from a given set
#'
#' @templateVar fn Disjunct
#' @template x
#' @param y [\code{atomic}]\cr
#'  Other Set.
#' @template fmatch
#' @template checker
#' @template set
#' @family set
#' @export
#' @examples
#' testDisjunct(1L, letters)
#' testDisjunct(c("a", "z"), letters)
#'
#' # x is not converted before the comparison (except for numerics)
#' testDisjunct(factor("a"), "a")
#' testDisjunct(1, "1")
#' testDisjunct(1, as.integer(1))
checkDisjunct = function(x, y, fmatch = FALSE) {
  qassert(x, "a")
  qassert(y, "a")

  if (isTRUE(fmatch) && requireNamespace("fastmatch", quietly = TRUE))
    match = fastmatch::fmatch

  check_disjunct_internal(x, y, match)
}

#' @export
#' @rdname checkDisjunct
check_disjunct = checkDisjunct

#' @export
#' @include makeAssertion.R
#' @template assert
#' @rdname checkDisjunct
assertDisjunct = makeAssertionFunction(checkDisjunct, use.namespace = FALSE)

#' @export
#' @rdname checkDisjunct
assert_disjunct = assertDisjunct

#' @export
#' @include makeTest.R
#' @rdname checkDisjunct
testDisjunct = makeTestFunction(checkDisjunct)

#' @export
#' @rdname checkDisjunct
test_disjunct = testDisjunct

#' @export
#' @include makeExpectation.R
#' @template expect
#' @rdname checkDisjunct
expect_disjunct = makeExpectationFunction(checkDisjunct, use.namespace = FALSE)
