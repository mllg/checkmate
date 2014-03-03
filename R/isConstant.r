#' @useDynLib checkmate c_is_constant
isConstant = function(x, tol=.Machine$double.eps^0.5) {
  qassert(tol, "R1")
  if (length(x) <= 1L)
    return(TRUE)

  n.na = sum(is.na(x))
  if (n.na > 0L)
    return(n.na == length(x))

  if (is.double(x)) {
    .Call("c_is_constant", x, as.double(tol),PACKAGE="checkmate")
  } else if (is.atomic(x)) {
    all(tail(x, -1L) == x[[1L]])
  } else {
    all(vlapply(tail(x, -1L), identical, y=x[[1L]]))
  }
}

