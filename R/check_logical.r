#' Check if an argument is a vector of type logical
#'
#' @templateVar fn Logical
#' @template na-handling
#' @template checker
#' @param ... [ANY]\cr
#'  Additional parameters used in a call of \code{\link{checkVector}}.
#' @family basetypes
#' @export
#' @examples
#'  test(TRUE, "logical")
#'  test(TRUE, "logical", min.len = 1)
checkLogical = function(x, ...) {
  if (!is.logical(x) && !allMissingAtomic(x))
    return(mustBeClass("logical"))
  checkVectorProps(x, ...)
}

#' @rdname checkLogical
#' @export
assertLogical = function(x, ..., .var.name) {
  makeAssertion(checkLogical(x, ...), vname(x, .var.name))
}

#' @rdname checkLogical
#' @export
testLogical = function(x, ...) {
  makeTest(checkLogical(x, ...))
}
