isConstant = function(x, tol=.Machine$double.eps^0.5, na.rm=FALSE) {
  qassert(tol, "R1")
  qassert(na.rm, "B1")
  if (length(x) <= 1L)
    return(TRUE)

  if (is.numeric(x))
    diff(range(x)) <= tol
  else
    all(tail(x, -1L) == x[[1L]])
}
