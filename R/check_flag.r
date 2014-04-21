#' Check if an argument is a flag
#'
#' A flag a a single logical value which is not missing.
#'
#' @template checker
#' @param na.ok [\code{logical(1)}]\cr
#'  Are missing values allowed? Default is \code{FALSE}.
#' @family checker
#' @export
#' @examples
#'  test(TRUE, "flag")
#'  test(1, "flag")
check_flag = function(x, na.ok = FALSE) {
  qassert(na.ok, "B1")
  if(length(x) != 1L)
    return("'%s' must have length 1")
  if(!is.logical(x))
    return("'%s' must be logical")
  if (!na.ok && is.na(x))
    return("'%s' may not be NA")
  return(TRUE)
}
