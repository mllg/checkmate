#' Checks if all elements of a vector are equal
#'
#' @templateVar id ConstantVector
#' @template testfuns
#' @param tol [\code{double(1)}]\cr
#'  Numerical tolerance used if \code{x} is of type \code{double} or \code{complex}.
#'  Default is \code{sqrt(.Machine$double.eps)}.
#' @export
#' @seealso \code{link{assertVariableVector}}
#' @useDynLib checkmate c_is_constant
assertConstantVector = function(x, tol = .Machine$double.eps^0.5, .var.name) {
  amsg(testConstantVector(x, tol), vname(x, .var.name))
}

#' @rdname assertConstantVector
#' @export
isConstantVector = function(x, tol = .Machine$double.eps^0.5) {
  isTRUE(testConstantVector(x, tol))
}

#' @rdname assertConstantVector
#' @export
asConstant = function(x, tol = .Machine$double.eps^0.5, .var.name) {
  assertConstantVector(x, tol = tol, .var.name = vname(x, .var.name))
  x
}

testConstantVector = function(x, tol = .Machine$double.eps^0.5) {
  if (!testConstantVectorHelper(x, tol))
    return("'%s' must have constant elements")
  return(TRUE)
}

testConstantVectorHelper = function(x, tol) {
  callConstant = function(x, tol) {
    .Call("c_is_constant", x, as.double(tol), PACKAGE="checkmate")
  }

  if (length(x) <= 1L)
    return(TRUE)

  n.na = sum(is.na(x))
  if (n.na > 0L)
    return(n.na == length(x))

  if (is.double(x)) {
    qassert(tol, "N1")
    callConstant(x, tol)
  } else if (is.complex(x)) {
    qassert(tol, "N1")
    callConstant(Re(x), tol) && callConstant(Im(x), tol)
  } else if (is.atomic(x)) {
    all(x == x[[1L]])
  } else {
    all(vapply(tail(x, -1L), identical, y=x[[1L]], FUN.VALUE=NA))
  }
}
