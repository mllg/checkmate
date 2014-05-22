#' Check if an argument is a single numeric
#'
#' @templateVar fn Number
#' @template na-handling
#' @template checker
#' @param na.ok [\code{logical(1)}]\cr
#'  Are missing values allowed? Default is \code{FALSE}.
#' @export
#' @examples
#'  testNumber(1)
#'  testNumber(1:2)
checkNumber = function(x, na.ok = FALSE) {
  if (length(x) != 1L || !is.numeric(x))
    return("Must be a number")
  if (!isTRUE(na.ok) && is.na(x))
    return("May not be NA")
  return(TRUE)
}

#' @rdname checkNumber
#' @export
assertNumber = function(x, na.ok = FALSE, .var.name) {
  makeAssertion(checkNumber(x, na.ok), vname(x, .var.name))
}

#' @rdname checkNumber
#' @export
testNumber = function(x, na.ok = FALSE) {
  isTRUE(checkNumber(x, na.ok))
}
