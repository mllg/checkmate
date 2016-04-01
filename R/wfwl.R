#' @title Get the index of the first/last TRUE
#'
#' @description
#' A quick C implementation for \dQuote{which.first} (\code{head(which(x), 1)}) and
#' \dQuote{which.last} (\code{tail(which(x), 1)}).
#'
#' @param x [\code{logical}]\cr
#'  Logical vector.
#' @param use.names [\code{logical(1)}]\cr
#'  If \code{TRUE} and \code{x} is named, the result is also
#'  named.
#' @return [\code{integer(1)} | \code{integer(0)}].
#'  Returns the index of the first/last \code{TRUE} value in \code{x} or
#'  an empty integer vector if none is found. NAs are ignored.
#' @useDynLib checkmate c_which_first
#' @export
#' @examples
#' wf(c(FALSE, TRUE))
#' wl(c(FALSE, FALSE))
#' wf(NA)
wf = function(x, use.names = TRUE) {
  .Call(c_which_first, x, use.names)
}

#' @rdname wf
#' @export
#' @useDynLib checkmate c_which_last
wl = function(x, use.names = TRUE) {
  .Call(c_which_last, x, use.names)
}
