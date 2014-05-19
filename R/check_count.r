#' Check if an argument is a count
#'
#' A count is a non-negative integer.
#'
#' @template na-handling
#' @template checker
#' @param na.ok [\code{logical(1)}]\cr
#'  Are missing values allowed? Default is \code{FALSE}.
#' @export
#' @examples
#'  test(1, "count")
#'  test(-1, "count")
#'  test(Inf, "count")
check_count = function(x, na.ok = FALSE) {
  qassert(na.ok, "B1")
  if (length(x) != 1L)
    return(mustLength1())
  if (is.na(x))
    return(ifelse(na.ok, TRUE, "'%s' may not be NA"))
  if (!qcheck(x, "x1"))
    return("'%s' must be integerish")
  if (x < 0)
    return("'%s' must be >= 0")
  return(TRUE)
}
