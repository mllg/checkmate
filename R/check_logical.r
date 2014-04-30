#' Check if an argument is a vector of type logical
#'
#' @note This function does not distinguish between
#' \code{NA}, \code{NA_integer_}, \code{NA_real_}, \code{NA_complex_}
#' and \code{NA_character_}.
#'
#' @template checker
#' @param ... [ANY]\cr
#'  Additional parameters used in a call of \code{\link{check_vector}}.
#' @family basetypes
#' @export
#' @examples
#'  test(TRUE, "logical")
#'  test(TRUE, "logical", min.len = 1)
check_logical = function(x, ...) {
  if (!is.logical(x) && !allMissingAtomic(x))
    return("'%s' must be logical")
  check_vector_props(x, ...)
}
