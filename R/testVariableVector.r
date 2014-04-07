#' Checks if elements of a vector are variable
#'
#' @templateVar id VariableVector
#' @template testfuns
#' @inheritParams assertConstantVector
#' @seealso \code{link{assertConstantVector}}
#' @export
#' @useDynLib checkmate c_is_constant
#' @examples
#' print(isVariableVector(c(1, NA)))
#'
#' x = c(0, 1 - 0.9 - 0.1)
#' print(identical(x[1], x[2]))
#' print(isVariableVector(x))
assertVariableVector = function(x, tol = .Machine$double.eps^0.5, .var.name) {
  amsg(testVariableVector, vname(x, .var.name))
}

#' @rdname assertVariableVector
#' @export
isVariableVector = function(x, tol = .Machine$double.eps^0.5) {
  isTRUE(testVariableVector(x, tol))
}

#' @rdname assertVariableVector
#' @export
asVariableVector = function(x, tol = .Machine$double.eps^0.5, .var.name) {
  assertVariableVector(x, tol = tol, .var.name = vname(x, .var.name))
  x
}

testVariableVector = function(x, tol = .Machine$double.eps^0.5) {
  if (testConstantVectorHelper(x, tol))
    return("'%s' must have variable elements")
  return(TRUE)
}
