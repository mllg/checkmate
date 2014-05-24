#' Check if an argument is a count
#'
#' A count is a non-negative integer.
#'
#' @templateVar fn Count
#' @template na-handling
#' @template checker
#' @param na.ok [\code{logical(1)}]\cr
#'  Are missing values allowed? Default is \code{FALSE}.
#' @export
#' @examples
#'  testCount(1)
#'  testCount(-1)
#'  testCount(Inf)
checkCount = function(x, na.ok = FALSE) {
  if (length(x) != 1L)
    return("Must have length 1")
  if (!qtest(x, "x1"))
    return("Must be integerish")
  if (is.na(x))
    return(if(isTRUE(na.ok)) TRUE else "May not be NA")
  if (x < 0)
    return("Must be >= 0")
  return(TRUE)
}

#' @rdname checkCount
#' @export
assertCount = function(x, na.ok = FALSE, .var.name) {
  makeAssertion(checkCount(x, na.ok), vname(x, .var.name))
}

#' @rdname checkCount
#' @export
testCount = function(x, na.ok = FALSE) {
  isTRUE(checkCount(x, na.ok))
}
