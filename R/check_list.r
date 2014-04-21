#' Check if an argument is a list
#'
#' @template checker
#' @param ... [ANY]\cr
#'  Additional parameters used in a call of \code{\link{check_vector}}.
#' @param types [\code{character}]\cr
#'  Restrict elements to be atomic. Tests for \dQuote{logical}, \dQuote{integer},
#'  \dQuote{double}, \dQuote{numeric}, \dQuote{character}, \dQuote{factor} or
#'  \dQuote{NULL}.
#'  Defaults to \code{character(0)} (no type check).
#' @family checker
#' @export
check_list = function(x, types = character(0L), ...) {
  if (!is.vector(x, "list"))
    return("'%s' must be a list")
  check_vector_props(x, ...) %and% check_list_props(x, types)
}

check_list_props = function(x, types = character(0L)) {
  if (length(types) == 0L)
    return(TRUE)
  allowed.types = c("logical", "integer", "double", "numeric", "character", "factor", "NULL")
  types = unique(match.arg(types, choices = allowed.types, several.ok = TRUE))

  ok = logical(length(x))
  for (type in types) {
    fun = match.fun(sprintf("is.%s", tolower(type)))
    ok = ok | vapply(x, fun, FUN.VALUE = NA, USE.NAMES = FALSE)
    if (all(ok))
      return(TRUE)
  }
  return(sprintf("'%%s' may only contain the following atomic types: %s", collapse(types)))
}
