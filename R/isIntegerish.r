isIntegerish = function(x, tol = .Machine$double.eps^.5) {
  .Call("c_is_integerish", x, as.double(tol), PACKAGE = "checkmate")
}
