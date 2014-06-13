#' Find the index of first/last \code{TRUE} value in a logical vector.
#'
#' @param x [\code{logical}]\cr
#'   Logical vector.
#' @param use.names [\code{logical(1)}]\cr
#'   If \code{TRUE} and \code{x} is named, the result is also
#'   named.
#' @return [\code{integer(1)} | \code{integer(0)}].
#'   Returns the index of the first/last \code{TRUE} value in \code{x} or
#'   an empty integer vector if none is found.
#' @useDynLib checkmate c_which_first
#' @export
#' @examples
#'  which.first(c(FALSE, TRUE))
#'  which.last(c(FALSE, FALSE))
which.first = function(x, use.names = TRUE) {
  .Call("c_which_first", x, use.names, PACKAGE = "checkmate")
}

#' @rdname which.first
#' @export
#' @useDynLib checkmate c_which_last
which.last = function(x, use.names = TRUE) {
  .Call("c_which_last", x, use.names, PACKAGE = "checkmate")
}
