#' Checks if an argument is a list
#'
#' @templateVar id List
#' @template testfuns
#' @param ... [ANY]\cr
#'  Additional parameters used in a call of \code{\link{isVector}}
#'  or \code{\link{assertVector}}.
#' @param types [\code{character}]\cr
#'  Restrict elements to be atomic. Tests for \dQuote{logical}, \dQuote{integer},
#'  \dQuote{double}, \dQuote{numeric}, \dQuote{character}, \dQuote{factor} or
#'  \dQuote{NULL}.
#'  Defaults to \code{character(0)} (no type check).
#' @family basetypes
#' @export
assertList = function(x, types = character(0L), ..., .var.name) {
  amsg(testList(x, types, ...), vname(x, .var.name))
}

#' @rdname assertList
#' @export
isList = function(x, types = character(0L), ...) {
  isTRUE(testList(x, types, ...))
}

#' @rdname assertList
#' @export
asList = function(x, types = character(0L), ..., .var.name) {
  assertList(x, types, ..., .var.name = vname(x, .var.name))
  x
}

testList = function(x, types = character(0L), ...) {
  if (!is.vector(x, "list"))
    return("'%s' must be a list")
  testVectorProps(x, ...) %and% testListProps(x, types)
}

testListProps = function(x, types = character(0L)) {
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
  return(sprintf("'%%s' may only contain the following atomic types: %s", paste0(types, collapse = ",")))
}
