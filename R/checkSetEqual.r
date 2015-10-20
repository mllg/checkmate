#' Check if object is a subset of a given set
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
#' @family set
#' @export
#' @examples
#'  testSetEqual(c("a", "b"), c("a", "b"))
#'  testSetEqual(1:3, 1:4)
checkSetEqual = function(x, y, ordered = FALSE) {
  qassert(x, "a")
  qassert(y, "a")
  qassert(ordered, "B1")
  if (ordered) {
    if (length(x) != length(y) || any(xor(is.na(x), is.na(y)) | x != y, na.rm = TRUE))
      return(sprintf("Must be equal to {'%s'}", collapse(y, "','")))
  } else {
    if (any(match(x, y, 0L) == 0L) || any(match(y, x, 0L) == 0L))
      return(sprintf("Must be equal to set {'%s'}", collapse(y, "','")))
  }
  return(TRUE)
}

#' @rdname checkSetEqual
#' @export
assertSetEqual = function(x, y, ordered = FALSE, add = NULL, .var.name) {
  res = checkSetEqual(x, y, ordered = ordered)
  makeAssertion(res, vname(x, .var.name), add)
}

#' @rdname checkSetEqual
#' @export
testSetEqual = function(x, y, ordered = FALSE) {
  res = checkSetEqual(x, y, ordered = ordered)
  isTRUE(res)
}

#' @rdname checkSetEqual
#' @template expect
#' @export
expect_set_equal = function(x, y, ordered = FALSE, info = NULL, label = NULL) {
  res = checkSetEqual(x, y, ordered = ordered)
  makeExpectation(res, info = info, label = vname(x, label))
}
