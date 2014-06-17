#' @useDynLib checkmate c_is_integerish
isIntegerish = function(x, tol = .Machine$double.eps^.5) {
  .Call("c_is_integerish", x, tol, PACKAGE = "checkmate")
}
