testConstantHelper = function(x, tol) {
  callConstant = function(x, tol) {
    .Call("c_is_constant", x, as.double(tol), PACKAGE="checkmate")
  }

  qassert(tol, "R1")
  if (length(x) <= 1L)
    return(TRUE)

  n.na = sum(is.na(x))
  if (n.na > 0L)
    return(n.na == length(x))

  if (is.double(x)) {
    callConstant(x, tol)
  } else if (is.complex(x)) {
    callConstant(Re(x), tol) && callConstant(Im(x), tol)
  } else if (is.atomic(x)) {
    all(x == x[[1L]])
  } else {
    all(vlapply(tail(x, -1L), identical, y=x[[1L]]))
  }
}

testConstant = function(x, tol=.Machine$double.eps^0.5) {
  if (!testConstantHelper(x, tol))
    return("'%s' must have constant elements")
  return(TRUE)
}

testVariable = function(x, tol=.Machine$double.eps^0.5) {
  if (testConstantHelper(x, tol))
    return("'%s' must have variable elements")
  return(TRUE)
}

#' Checks if all elements of a vector are constant
#'
#' @param x [\code{ANY}]\cr
#'  Object to check.
#' @param tol [\code{double(1)}]\cr
#'  Numerical tolerance used if \code{x} is of type \code{double} or \code{complex}.
#'  Default is \code{sqrt(.Machine$double.eps)}.
#' @return [\code{logical(1)}] Returns \code{TRUE} on success.
#'  Throws an exception on failure for assertion.
#' @export
#' @useDynLib checkmate c_is_constant
#' @examples
#' print(checkVariable(c(1, NA)))
#'
#' x = c(0, 1 - 0.9 - 0.1)
#' print(identical(x[1], x[2]))
#' print(checkVariable(x))
checkConstant = function(x, tol=.Machine$double.eps^0.5) {
  isTRUE(testConstant(x, tol))
}

#' @rdname checkConstant
#' @export
asssertConstant = function(x, tol=.Machine$double.eps^0.5) {
  amsg(testConstant(x, tol), dps(x))
}

#' @rdname checkConstant
#' @export
checkVariable = function(x, tol=.Machine$double.eps^0.5) {
  isTRUE(testVariable(x, tol))
}

#' @rdname checkConstant
#' @export
asssertVariable = function(x, tol=.Machine$double.eps^0.5) {
  amsg(testVariable, dps(x))
}

