#' Check if an argument is a vector of type logical
#'
#' @template na-handling
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
    return(mustBeClass("logical"))
  check_vector_props(x, ...)
}
