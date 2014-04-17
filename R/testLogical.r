#' Checks if an argument is a logical vector
#'
#' @templateVar id Logical
#' @template testfuns
#' @param ... [ANY]\cr
#'  Additional parameters used in a call of \code{\link{isVector}}
#'  or \code{\link{assertVector}}.
#' @family basetypes
#' @export
assertLogical = function(x, ..., .var.name) {
  amsg(testLogical(x, ...), vname(x, .var.name))
}

#' @rdname assertLogical
#' @export
isLogical = function(x, ...) {
  isTRUE(testLogical(x, ...))
}

#' @rdname assertLogical
#' @export
asLogical = function(x, ..., .var.name) {
  assertLogical(x, ..., .var.name = vname(x, .var.name))
  x
}

testLogical = function(x, ...) {
  if (!is.logical(x))
    return("'%s' must be logical")
  testVectorProps(x, ...)
}
