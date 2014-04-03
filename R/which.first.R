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
#'   If NAs are encountered before a \code{TRUE} and not omitted,
#'   the result is \code{NA_integer_}.
#' @export
#' @useDynLib checkmate c_first
which.first = function(x, use.names = TRUE) {
  .Call(c_first, x, use.names, package="checkmate")
}

#' @rdname which.first
#' @export
#' @useDynLib checkmate c_last
which.last = function(x, use.names = TRUE) {
  .Call(c_last, x, use.names, package="checkmate")
}
