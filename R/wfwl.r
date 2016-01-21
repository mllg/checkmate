#' @useDynLib checkmate c_which_first
wf = function(x, use.names = TRUE) {
  .Call(c_which_first, x, use.names)
}

#' @useDynLib checkmate c_which_last
wl = function(x, use.names = TRUE) {
  .Call(c_which_last, x, use.names)
}
