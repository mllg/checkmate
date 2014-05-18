#' Check if an argument is a flag
#'
#' A flag a a single logical value.
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
#'  test(TRUE, "flag")
#'  test(1, "flag")
check_flag = function(x, na.ok = FALSE) {
  qassert(na.ok, "B1")
  if(length(x) != 1L)
    return(mustLength1())
  if (is.na(x))
    return(ifelse(na.ok, TRUE, "'%s' may not be NA"))
  if(!is.logical(x))
    return(mustBeClass("logical"))
  return(TRUE)
}
