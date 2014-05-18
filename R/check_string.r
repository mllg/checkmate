#' Check if an argument is a string
#'
#' A string a character vector of length 1.
#'
#' @note This function does not distinguish between
#' \code{NA}, \code{NA_integer_}, \code{NA_real_}, \code{NA_complex_}
#' and \code{NA_character_}.
#'
#' @template checker
#' @param na.ok [\code{logical(1)}]\cr
#'  Are missing values allowed? Default is \code{FALSE}.
#' @param ... [ANY]\cr
#'  Additional parameters used in a call of \code{\link{check_character}}.
#' @export
#' @examples
#'  test("a", "string")
#'  test(letters, "string")
check_string = function(x, na.ok = FALSE, ...) {
  qassert(na.ok, "B1")
  if (length(x) != 1L)
    return(mustLength1())
  if (is.na(x))
    return(ifelse(na.ok, TRUE, "'%s' may not be NA"))
  if (!is.character(x))
    return(mustBeClass("character"))
  check_character_props(x, ...)
}
