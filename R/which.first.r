#' @useDynLib checkmate c_which_first
which.first = function(x, use.names = TRUE) {
  .Call("c_which_first", x, use.names, package="checkmate")
}

#' @useDynLib checkmate c_which_last
which.last = function(x, use.names = TRUE) {
  .Call("c_which_last", x, use.names, package="checkmate")
}
