#' Checks if an argument is a numeric
#'
#' @param x [\code{ANY}]\cr
#'  Object to check.
#' @param na.ok [\code{logical(1)}]\cr
#'  Are missing values allowed? Default is \code{TRUE}.
#' @param len [\code{integer(1)}]\cr
#'  Exact expected length of \code{x}.
#' @param min.len [\code{integer(1)}]\cr
#'  Minimal length of \code{x}.
#' @param max.len [\code{integer(1)}]\cr
#'  Maximal length of \code{x}.
#' @param lower [\code{numeric(1)}]\cr
#'  Lower value all elements of \code{x} must be greater than.
#' @param upper [\code{numeric(1)}]\cr
#'  Upper value all elements of \code{x} must be lower than.
#' @return [\code{logical(1)}] Returns \code{TRUE} on success.
#'  Throws an exception on failure for assertion.
#' @export
checkNum = function(x, na.ok=TRUE, len, min.len, max.len, lower, upper) {
  is.numeric(x) && isTRUE(testNumAttr(x, na.ok, len, min.len, max.len, lower, upper))
}

#' @rdname checkNum
#' @export
assertNum = function(x, na.ok=TRUE, len, min.len, max.len, lower, upper) {
  msg = if (is.numeric(x))
    testNumAttr(x, na.ok, len, min.len, max.len, lower, upper)
  else
    "'%s' must be numeric"
  amsg(msg, deparse(substitute(x)))
}
