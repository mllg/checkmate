#' Check if an argument is equal to a given set
#'
#' @templateVar fn Subset
#' @template x
#' @param y [\code{atomic}]\cr
#'  Set to compare with.
#' @param ordered [\code{logical(1)}]\cr
#' Check \code{x} to have the same length and order as \code{y}, i.e.
#' check using \dQuote{==} while handling \code{NA}s nicely.
#' Default is \code{FALSE}.
#' @template checker
#' @template set
#' @family set
#' @export
#' @examples
#' testSetEqual(c("a", "b"), c("a", "b"))
#' testSetEqual(1:3, 1:4)
#'
#' # x is converted before the comparison if necessary
#' # note that this is subject to change in a future version
#' testSetEqual(factor("a"), "a")
#' testSetEqual(1, "1")
#' testSetEqual(1, as.integer(1))
checkSetEqual = function(x, y, ordered = FALSE) {
  qassert(x, "a")
  qassert(y, "a")
  qassert(ordered, "B1")
  if (ordered) {
    if (length(x) != length(y) || any(xor(is.na(x), is.na(y)) | x != y, na.rm = TRUE))
      return(sprintf("Must be equal to {'%s'}", paste0(y, collapse = "','")))
  } else {
    if (any(match(x, y, 0L) == 0L) || any(match(y, x, 0L) == 0L))
      return(sprintf("Must be equal to set {'%s'}", paste0(y, collapse = "','")))
  }
  return(TRUE)
}

#' @export
#' @rdname checkSetEqual
check_set_equal = checkSetEqual

#' @export
#' @include makeAssertion.R
#' @template assert
#' @rdname checkSetEqual
assertSetEqual = makeAssertionFunction(checkSetEqual)

#' @export
#' @rdname checkSetEqual
assert_set_equal = assertSetEqual

#' @export
#' @include makeTest.R
#' @rdname checkSetEqual
testSetEqual = makeTestFunction(checkSetEqual)

#' @export
#' @rdname checkSetEqual
test_set_equal = testSetEqual

#' @export
#' @include makeExpectation.R
#' @template expect
#' @rdname checkSetEqual
expect_set_equal = makeExpectationFunction(checkSetEqual)
