#' @useDynLib checkmate c_is_integerish
isIntegerish = function(x, tol = sqrt(.Machine$double.eps)) {
  .Call(c_is_integerish, x, tol)
}
