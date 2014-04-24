#' Check if an argument is a complex vector
#'
#' @template checker
#' @param ... [ANY]\cr
#'  Additional parameters used in a call of \code{\link{check_vector}}.
#' @family checker
#' @export
#' @examples
#'  test(1L, "numeric")
#'  test(1., "numeric")
check_complex = function(x, ...) {
  if (!is.complex(x))
    return("'%s' must be complex")
  check_vector_props(x, ...)
}
