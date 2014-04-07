#' @rdname assertConstant
#' @export
checkVariable = function(x, tol = .Machine$double.eps^0.5) {
  isTRUE(testVariable(x, tol))
}

#' @rdname assertConstant
#' @export
assertVariable = function(x, tol = .Machine$double.eps^0.5, .var.name) {
  amsg(testVariable, vname(x, .var.name))
}

#' @rdname assertVariable
#' @export
asVariable = function(x, tol = .Machine$double.eps^0.5, .var.name) {
  assertVariable(x, tol = tol, .var.name = vname(x, .var.name))
  x
}

testVariable = function(x, tol = .Machine$double.eps^0.5) {
  if (testConstantHelper(x, tol))
    return("'%s' must have variable elements")
  return(TRUE)
}
