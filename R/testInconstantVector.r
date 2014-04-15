#' Checks if elements of a vector are variable
#'
#' @templateVar id InconstantVector
#' @template testfuns
#' @inheritParams assertConstantVector
#' @seealso \code{link{assertConstantVector}}
#' @export
#' @useDynLib checkmate c_is_constant
#' @examples
#' print(isInconstantVector(c(1, NA)))
#'
#' x = c(0, 1 - 0.9 - 0.1)
#' print(identical(x[1], x[2]))
#' print(isInconstantVector(x))
assertInconstantVector = function(x, tol = .Machine$double.eps^0.5, .var.name) {
  amsg(testInconstantVector(x, tol), vname(x, .var.name))
}

#' @rdname assertInconstantVector
#' @export
isInconstantVector = function(x, tol = .Machine$double.eps^0.5) {
  isTRUE(testInconstantVector(x, tol))
}

#' @rdname assertInconstantVector
#' @export
asInconstantVector = function(x, tol = .Machine$double.eps^0.5, .var.name) {
  assertInconstantVector(x, tol = tol, .var.name = vname(x, .var.name))
  x
}

testInconstantVector = function(x, tol = .Machine$double.eps^0.5) {
  if (testConstantVectorHelper(x, tol))
    return("'%s' must have inconstant (varying) elements")
  return(TRUE)
}
