#' Check if an argument is a single missing value
#'
#' @templateVar fn ScalarNA
#' @template x
#' @template checker
#' @family scalars
#' @export
#' @examples
#' testScalarNA(1)
#' testScalarNA(NA_real_)
#' testScalarNA(rep(NA, 2))
checkScalarNA = function(x) {
  if (length(x) != 1L || !is.na(x))
    return("Must be a scalar missing value")
  return(TRUE)
}
