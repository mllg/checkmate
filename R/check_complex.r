#' Check if an argument is a vector of type complex
#'
#' @template na-handling
#' @template checker
#' @param ... [ANY]\cr
#'  Additional parameters used in a call of \code{\link{checkVector}}.
#' @family basetypes
#' @export
#' @examples
#'  test(1L, "complex")
#'  test(1., "complex")
checkComplex = function(x, ...) {
  if (!is.complex(x) && !allMissingAtomic(x))
    return(mustBeClass("complex"))
  checkVectorProps(x, ...)
}

#' @rdname checkComplex
#' @export
assertComplex = function(x, ..., .var.name) {
  makeAssertion(checkComplex(x, ...), vname(x, .var.name))
}

#' @rdname checkComplex
#' @export
testComplex = function(x, ...) {
  makeTest(checkComplex(x, ...))
}
