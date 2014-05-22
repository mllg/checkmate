#' Check if an argument is a vector of type complex
#'
#' @templateVar fn Complex
#' @template na-handling
#' @template checker
#' @param ... [ANY]\cr
#'  Additional parameters used in a call of \code{\link{checkVector}}.
#' @family basetypes
#' @export
#' @examples
#'  testComplex(1)
#'  testComplex(1+1i)
checkComplex = function(x, ...) {
  if (!is.complex(x) && !allMissingAtomic(x))
    return("Must be complex")
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
  isTRUE(checkComplex(x, ...))
}
