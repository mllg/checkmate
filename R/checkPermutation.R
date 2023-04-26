#' Check if the arguments are permutations of each other.
#'
#' @description
#' In contrast to \code{\link{checkSetEqual}}, the function tests for a true
#' permutation of the two vectors and also considers duplicated values.
#' Missing values are being treated as actual values by default.
#' Does not work on raw values.
#'
#' @templateVar fn Permutation
#' @template x
#' @param y [\code{atomic}]\cr
#'  Vector to compare with. Atomic vector of type other than raw.
#' @param na.ok [\code{logical(1)}]\cr
#'  Are missing values allowed? Default is \code{TRUE}.
#' @template checker
#' @template set
#' @family set
#' @export
#' @examples
#' testPermutation(letters[1:2], letters[2:1])
#' testPermutation(letters[c(1, 1, 2)], letters[1:2])
#' testPermutation(c(NA, 1, 2), c(1, 2, NA))
#' testPermutation(c(NA, 1, 2), c(1, 2, NA), na.ok = FALSE)
checkPermutation = function(x, y, na.ok = TRUE) {
  qassert(x, "a")
  qassert(y, "a")

  if (is.raw(x) || is.raw(y)) {
    stop("Cannot check permutation on raw vectors")
  }

  # These are the cheap checks that we perform separately
  if (!isSameType(x, y) || length(x) != length(y)) {
    return(sprintf("Must be permutation of %s, but is %s", array_collapse(y), array_collapse(x)))
  }

  if (!na.ok && (anyNA(x) || anyNA(y))) {
    return("The parameter na.ok is set to FALSE but NAs were found.")
  }
  # This drops NAs
  xs = sort(x)
  ys = sort(y)

  # We handle NAs and the remaining non-NAs differently:
  # * NA: If na.ok is TRUE, the two vector must have the same number of NAs, this is checked by
  #       comparing the lengths, because the NAs are dropped in the sort above.
  # * non-NA: We sort the vector and check for equality (without NAs)

  if (length(xs) != length(ys) || any(xs != ys)) {
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
