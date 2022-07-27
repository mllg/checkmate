#' Check if the arguments are permutations of each other.
#' NAs are being treated as actual values by default.
#' @templateVar fn Permutation
#' @template x
#' @param y [\code{atomic}]\cr
#'  Vector to compare with. Atomic vector of type other than raw.
#' @param na.ok [\code{logical(1)}]\cr
#'  Are missing values allowed? Default is \code{TRUE}.
#' @template checker
#' @export
#' @examples
#' testPermutation(letters[1:2], letters[2:1])
#' testPermutation(letters[c(1, 1, 2)], letters[1:2])
#' testPermutation(c(NA, 1, 2), c(1, 2, NA))
#' testPermutation(c(NA, 1, 2), c(1, 2, NA), na.ok = FALSE)
checkPermutation = function(x, y, na.ok = TRUE) {
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

  if (!na.ok && (anyNA(x) || anyNA(y))) {
    return("The parameter na.ok is set to FALSE but NAs were found.")
  }
  xs = sort(x)
  ys = sort(y)

  # We can check for number of NAs by comparing lengths again as they are dropped by the sort


  if (length(xs) != length(ys) || any(xs != ys, na.rm = TRUE)) {
    return(sprintf("Must be permutation of %s, but is %s", array_collapse(ys), array_collapse(xs)))
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
