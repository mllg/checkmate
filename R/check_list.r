#' Check if an argument is a list
#'
#' @template checker
#' @param ... [ANY]\cr
#'  Additional parameters used in a call of \code{\link{check_vector}}.
#' @param types [\code{character}]\cr
#'  Character vector of class names. Each list element must inherit
#'  from at least one of the provided types.
#'  Defaults to \code{character(0)} (no check).
#' @family basetypes
#' @export
#' @examples
#'  test(list(), "list")
#'  test(as.list(iris), "list", types = c("numeric", "factor"))
check_list = function(x, types = character(0L), ...) {
  if (!is.vector(x, "list"))
    return(mustBeClass("list"))
  check_vector_props(x, ...) %and% check_list_props(x, types)
}

check_list_props = function(x, types = character(0L)) {
  if (length(types) == 0L)
    return(TRUE)
  qassert(types, "S")
  ok = vapply(x, inherits, what = types, FUN.VALUE = NA, USE.NAMES = FALSE)
  if (all(ok))
    return(TRUE)
  return(sprintf("'%%s' may only contain the following types: %s", collapse(types)))
}
