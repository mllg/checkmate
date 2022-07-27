#' Check if the arguments are permutations of each other
#' @templateVar fn Permutation
#' @template x
#' @param y [\code{atomic}]\cr
#'  Vector to compare with. Atomic vector of type other than raw.
#' @template checker
#' @export
#' @examples
#' testPermutation(letters[1:2], letters[2:1])
#' testPermutation(letters[c(1, 1, 2)], letters[1:2])
checkPermutation = function(x, y) {
  qassert(x, "a")
  qassert(y, "a")
  # raws cannot be sorted
  assert_false(is.raw(x))
  assert_false(is.raw(y))

  # now this is checkSetEqual(..., ordered = TRUE) with additional sorting.
  # Some properties can be checked before sorting
  if (!isSameType(x, y) || length(x) != length(y)) {
    return(sprintf("Must be permutation of %s, but is %s", array_collapse(y), array_collapse(x)))
  }

  x = sort(x)
  y = sort(y)

  # We can check for number of NAs by comparing lengths again as they are dropped by the sort
  if (length(x) != length(y) || any(x != y, na.rm = TRUE)) {
    return(sprintf("Must be permutation of %s, but is %s", array_collapse(y), array_collapse(x)))
  }
  return(TRUE)
}

#' @export
#' @rdname checkPermutation
check_permutation = checkPermutation

#' @export
#' @include makeAssertion.R
#' @template assert
#' @rdname checkPermutation
assertPermutation = makeAssertionFunction(checkPermutation, use.namespace = FALSE)

#' @export
#' @rdname checkPermutation
assert_permutation = assertPermutation

#' @export
#' @include makeTest.R
#' @rdname checkPermutation
testPermutation = makeTestFunction(checkPermutation)

#' @export
#' @rdname checkPermutation
test_permutation = testPermutation

#' @export
#' @include makeExpectation.R
#' @template expect
#' @rdname checkPermutation
expect_permutation = makeExpectationFunction(checkPermutation, use.namespace = FALSE)
