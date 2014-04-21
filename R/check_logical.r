#' Check if an argument is a logical vector
#'
#' @template checker
#' @param ... [ANY]\cr
#'  Additional parameters used in a call of \code{\link{check_vector}}.
#' @family checker
#' @export
#' @examples
#'  test(TRUE, "logical", min.len = 1)
check_logical = function(x, ...) {
  if (!is.logical(x))
    return("'%s' must be logical")
  check_vector_props(x, ...)
}
