#' Check if an argument is a count
#'
#' A count a a single integerish numeric >= 0 which is not missing.
#'
#' @template checker
#' @param na.ok [\code{logical(1)}]\cr
#'  Are missing values allowed? Default is \code{FALSE}.
#' @family checker
#' @export
#' @examples
#'  test(1, "count")
#'  test(Inf, "count")
check_count = function(x, na.ok = FALSE) {
  if (!qcheck(x, "x1"))
    return("'%s' must be integerish")
  if (is.na(x)) {
    if (!na.ok)
      return("'%s' may not be NA")
  } else if (x < 0) {
    return("'%s' must be >= 0")
  }
  return(TRUE)
}
