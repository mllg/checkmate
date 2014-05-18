#' Check if an argument is a vector of type complex
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
#'  test(1L, "complex")
#'  test(1., "complex")
check_complex = function(x, ...) {
  if (!is.complex(x) && !allMissingAtomic(x))
    return(mustBeClass("complex"))
  check_vector_props(x, ...)
}
