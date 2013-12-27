#' Converts a numeric object to a integer, if possible
#'
#' @param x [\code{ANY}]\cr
#'  Object to check.
#' @param tolerance [\code{double(1)}]\cr
#'  Numerical tolerance to check if a double could be an integer.
#'  Default is \code{sqrt(.Machine$double.eps)}.
#' @export
#' @useDynLib checkmate c_is_integerish
#' @export
is.integerish = function(x, tolerance = .Machine$double.eps^.5) {
  .Call("c_is_integerish", x, as.double(tolerance), PACKAGE="checkmate")
}
