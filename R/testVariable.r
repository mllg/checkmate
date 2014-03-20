testConstant = function(x, tol) {
  qassert(tol, "R1")
  if (length(x) <= 1L)
    return(TRUE)

  n.na = sum(is.na(x))
  if (n.na > 0L)
    return(n.na == length(x))

  myCall = function(x)
    .Call("c_is_constant", x, tol, PACKAGE="checkmate")

  if (is.double(x)) {
    myCall(x)
  } else if (is.complex(x)) {
    myCall(Re(x)) && myCall(Im(x))
  } else if (is.atomic(x)) {
    all(tail(x, -1L) == x[[1L]])
  } else {
    all(vapply(tail(x, -1L), identical, NA, y=x[[1L]]))
  }
}

#' Checks if all elements are constant
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
checkVariable = function(x, tol=.Machine$double.eps^0.5) {
  !testConstant(x, tol)
}

#' @rdname checkVariable
#' @export
asssertVariable = function(x, tol=.Machine$double.eps^0.5) {
  if (testConstant(x, tol))
    amsg("Values of '%s' must vary", deparse(substitute(x)))
}
