#' Checks if all elements of a vector are constant
#'
#' @param x [\code{ANY}]\cr
#'  Object to check.
#' @param tol [\code{double(1)}]\cr
#'  Numerical tolerance used if \code{x} is of type \code{double} or \code{complex}.
#'  Default is \code{sqrt(.Machine$double.eps)}.
#' @param .var.name [\code{logical(1)}]\cr
#'  Argument name to print in error message. If missing,
#'  the name of \code{x} will be retrieved via \code{\link[base]{substitute}}.
#' @inheritParams shared-params
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
assertConstant = function(x, tol = .Machine$double.eps^0.5, .var.name) {
  amsg(testConstant(x, tol), vname(x, .var.name))
}

#' @rdname assertConstant
#' @export
checkConstant = function(x, tol = .Machine$double.eps^0.5) {
  isTRUE(testConstant(x, tol))
}

#' @rdname assertConstant
#' @export
asConstant = function(x, tol = .Machine$double.eps^0.5, .var.name) {
  assertConstant(x, tol = tol, .var.name = vname(x, .var.name))
  x
}

testConstant = function(x, tol = .Machine$double.eps^0.5) {
  if (!testConstantHelper(x, tol))
    return("'%s' must have constant elements")
  return(TRUE)
}

testConstantHelper = function(x, tol) {
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
    all(vlapply(tail(x, -1L), identical, y=x[[1L]]))
  }
}
