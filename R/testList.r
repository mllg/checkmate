#' Checks if an argument is a list
#'
#' @param x [\code{ANY}]\cr
#'  Object to check.
#' @param ... [ANY]\cr
#'  Additional parameters used in a call of \code{\link{checkVector}}
#'  or \code{\link{assertVector}}.
#' @param .var.name [\code{logical(1)}]\cr
#'  Argument name to print in error message. If missing,
#'  the name of \code{x} will be retrieved via \code{\link[base]{substitute}}.
#' @return [\code{logical(1)}] Returns \code{TRUE} on success.
#'  Throws an exception on failure for assertion.
#' @export
assertList = function(x, ..., .var.name) {
  amsg(testVectorProps(x, ...), vname(x, .var.name))
  amsg(testList(x), vname(x, .var.name))
}

#' @rdname assertList
#' @export
checkList = function(x, ...) {
  isTRUE(testVectorProps(x, ...)) && isTRUE(testList(x))
}

#' @rdname assertList
#' @export
asList = function(x, ..., .var.name) {
  assertList(x, ..., .var.name = vname(x, .var.name))
  x
}

testList = function(x) {
  if (!is.vector(x, "list"))
    return("'%s' must be a list")
  return(TRUE)
}
