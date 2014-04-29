#' Check if an argument is a count
#'
#' @note This function does not distinguish between
#' \code{NA}, \code{NA_integer_}, \code{NA_real_}, \code{NA_complex_}
#' and \code{NA_character_}.
#'
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
    return("'%s' must have length 1")
  if (is.na(x))
    return(ifelse(na.ok, TRUE, "'%s' may not be NA"))
  if (!qcheck(x, "x1"))
    return("'%s' must be integerish")
  if (x < 0)
    return("'%s' must be >= 0")
  return(TRUE)
}
