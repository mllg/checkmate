wf = function(x, use.names = TRUE) {
  .Call("c_which_first", x, use.names, PACKAGE = "checkmate")
}

wl = function(x, use.names = TRUE) {
  .Call("c_which_last", x, use.names, PACKAGE = "checkmate")
}
