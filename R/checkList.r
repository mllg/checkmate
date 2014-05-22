#' Check if an argument is a list
#'
#' @templateVar fn List
#' @template checker
#' @param ... [ANY]\cr
#'  Additional parameters used in a call of \code{\link{checkVector}}.
#' @param types [\code{character}]\cr
#'  Character vector of class names. Each list element must inherit
#'  from at least one of the provided types.
#'  Defaults to \code{character(0)} (no check).
#' @family basetypes
#' @export
#' @examples
#'  test(list(), "list")
#'  test(as.list(iris), "list", types = c("numeric", "factor"))
checkList = function(x, types = character(0L), ...) {
  if (!is.vector(x, "list"))
    return("Must be a list")
  checkVectorProps(x, ...) %and% checkListProps(x, types)
}

checkListProps = function(x, types = character(0L)) {
  if (length(types) == 0L)
    return(TRUE)
  qassert(types, "S")
  ok = vapply(x, inherits, what = types, FUN.VALUE = NA, USE.NAMES = FALSE)
  if (all(ok))
    return(TRUE)
  return(sprintf("May only contain the following types: %s", collapse(types)))
}

#' @rdname checkList
#' @export
assertList = function(x, types = character(0L), ..., .var.name) {
  makeAssertion(checkList(x, types, ...), vname(x, .var.name))
}

#' @rdname checkList
#' @export
testList = function(x, types = character(0L), ...) {
  isTRUE(checkList(x, types, ...))
}
