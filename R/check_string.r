#' Check if an argument is a string
#'
#' A string a character vector of length 1.
#'
#' @template checker
#' @param na.ok [\code{logical(1)}]\cr
#'  Are missing values allowed? Default is \code{FALSE}.
#' @param ... [ANY]\cr
#'  Additional parameters used in a call of \code{\link{check_character}}.
#' @export
check_string = function(x, na.ok = FALSE, ...) {
  qassert(na.ok, "B1")
  if(length(x) != 1L || !is.character(x))
    return("'%s' must be a scalar string")
  if (!na.ok && is.na(x))
    return("'%s' may not be NA")
  check_character_props(x, ...)
}
