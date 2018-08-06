#' Check if an argument is a bit vector
#'
#' @templateVar fn Bit
#' @template x
#' @inheritParams checkVector
#' @param min.0 [\code{integer(1)}]\cr
#'  Minimum number of elements being \dQuote{0}/\code{FALSE}/off.
#' @param min.1 [\code{integer(1)}]\cr
#'  Minimum number of elements being \dQuote{1}/\code{TRUE}/on.
#' @template null.ok
#' @template checker
#' @export
#' @examples
#' library(bit)
#' x = as.bit(replace(logical(10), sample(10, 5), TRUE))
#' testBit(x, len = 10, min.0 = 1)
checkBit = function(x, len = NULL, min.len = NULL, max.len = NULL, min.0 = NULL, min.1 = NULL, null.ok = FALSE) {
  if (!requireNamespace("bit", quietly = TRUE))
    stop("Install package 'bit' to perform checks on bit vectors")

  qassert(null.ok, "B1")
  if (is.null(x)) {
    if (null.ok)
      return(TRUE)
    return("Must be a bit, not 'NULL'")
  }

  if (!bit::is.bit(x))
    return(paste0("Must be a bit", if (null.ok) " (or 'NULL')" else "", sprintf(", not %s", guessType(x))))

  n = bit::length.bit(x)
  if (!is.null(len)) {
    qassert(len, "X1")
    if (len != n)
      return(sprintf("Must have length %i, but has length %i", len, n))
  }

  if (!is.null(min.len)) {
    qassert(min.len, "X1")
    if (n < min.len)
      return(sprintf("Must have length >= %i, but has length %i", min.len, n))
  }

  if (!is.null(max.len)) {
    qassert(max.len, "X1")
    if (n > max.len)
      return(sprintf("Must have length <= %i, but has length %i", max.len, n))
  }

  if (!is.null(min.0) || !is.null(min.1)) {
    s = bit::sum.bit(x)

    if (!is.null(min.0)) {
      qassert(min.0, "X1[0,)")
      if (n - s < min.0)
        return(sprintf("Must have at least %i elements being '0', has %i", n, n - s))
    }

    if (!is.null(min.1)) {
      qassert(min.1, "X1[0,)")
      if (s < min.1)
        return(sprintf("Must have at least %i elements being '1', has %i", n, s))
    }
  }

  return(TRUE)
}

#' @export
#' @rdname checkBit
check_bit = checkBit

#' @export
#' @include makeAssertion.R
#' @template assert
#' @rdname checkBit
assertBit = makeAssertionFunction(checkBit, use.namespace = FALSE)

#' @export
#' @rdname checkBit
assert_bit = assertBit

#' @export
#' @include makeTest.R
#' @rdname checkBit
testBit = makeTestFunction(checkBit)

#' @export
#' @rdname checkBit
test_bit = testBit

#' @export
#' @include makeExpectation.R
#' @template expect
#' @rdname checkBit
expect_bit = makeExpectationFunction(checkBit, use.namespace = FALSE)
