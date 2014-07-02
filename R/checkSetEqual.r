#' Check if object is a subset of a given set
#'
#' @templateVar fn Subset
#' @template checker
#' @param y [\code{atomic}]\cr
#'  Set to compare with.
#' @family set
#' @export
#' @examples
#'  testSetEqual(c("a", "b"), c("a", "b"))
#'  testSetEqual(1:3, 1:4)
checkSetEqual = function(x, y) {
  qassert(x, "a")
  qassert(y, "a")
  if (any(match(x, y, 0L) == 0L) || any(match(y, x, 0L) == 0L))
    return(sprintf("Must be equal to set {'%s'}", collapse(y, "','")))
  return(TRUE)
}

#' @rdname checkSetEqual
#' @export
assertSetEqual = function(x, y, .var.name) {
  res = checkSetEqual(x, y)
  makeAssertion(res, vname(x, .var.name))
}

#' @rdname checkSetEqual
#' @export
testSetEqual = function(x, y) {
  isTRUE(checkSetEqual(x, y))
}
