#' Checks if an argument is a list
#'
#' @templateVar id List
#' @template testfuns
#' @param ... [ANY]\cr
#'  Additional parameters used in a call of \code{\link{isVector}}
#'  or \code{\link{assertVector}}.
#' @family basetypes
#' @export
assertList = function(x, ..., .var.name) {
  amsg(testList(x, ...), vname(x, .var.name))
}

#' @rdname assertList
#' @export
isList = function(x, ...) {
  isTRUE(testList(x, ...))
}

#' @rdname assertList
#' @export
asList = function(x, ..., .var.name) {
  assertList(x, ..., .var.name = vname(x, .var.name))
  x
}

testList = function(x, ...) {
  if (!is.vector(x, "list"))
    return("'%s' must be a list")
  testVectorProps(x, ...)
}
