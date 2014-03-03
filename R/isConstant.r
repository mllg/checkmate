#' Checks if all elements are constant
#'
#' @param x [\code{ANY}]\cr
#'  Object to check.
#' @param tol [\code{double(1)}]\cr
#'  Numerical tolerance used if \code{x} is of type \code{double} or \code{complex}.
#'  Default is \code{sqrt(.Machine$double.eps)}.
#' @return [logical(1)]: \code{TRUE} if \code{x} is constant,
#'    \code{FALSE} otherwise.
#' @export
#' @useDynLib checkmate c_is_constant
#' @examples
#' print(isConstant(c(1, NA)))
#'
#' x = c(0, 1 - 0.9 - 0.1)
#' print(identical(x[1], x[2]))
#' print(isConstant(x))
isConstant = function(x, tol=.Machine$double.eps^0.5) {
  qassert(tol, "R1")
  if (length(x) <= 1L)
    return(TRUE)

  n.na = sum(is.na(x))
  if (n.na > 0L)
    return(n.na == length(x))

  if (is.double(x)) {
    .Call("c_is_constant", x, tol, PACKAGE="checkmate")
  } else if (is.complex(x)) {
    .Call("c_is_constant", Re(x), tol, PACKAGE="checkmate") && .Call("c_is_constant", Im(x), tol, PACKAGE="checkmate")
  } else if (is.atomic(x)) {
    all(tail(x, -1L) == x[[1L]])
  } else {
    all(vlapply(tail(x, -1L), identical, y=x[[1L]]))
  }
}
