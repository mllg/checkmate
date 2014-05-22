#' Check if an argument is single numeric
#'
#' @templateVar fn Count
#' @template na-handling
#' @template checker
#' @param na.ok [\code{logical(1)}]\cr
#'  Are missing values allowed? Default is \code{FALSE}.
#' @export
#' @examples
#'  test(1, "count")
#'  test(-1, "count")
#'  test(Inf, "count")
checkNumber = function(x, na.ok = FALSE) {
  if (length(x) != 1L || !is.numeric(x))
    return("Must be a number")
  if (!isTRUE(na.ok) && is.na(x))
    return("May not be NA")
  return(TRUE)
}

#' @rdname checkCount
#' @export
assertNumber = function(x, na.ok = FALSE, .var.name) {
  makeAssertion(checkNumber(x, na.ok), vname(x, .var.name))
}

#' @rdname checkCount
#' @export
testNumber = function(x, na.ok = FALSE) {
  isTRUE(checkNumber(x, na.ok))
}
