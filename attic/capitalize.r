#' @useDynLib checkmate c_capitalize
capitalize = function(x) {
 .Call("c_capitalize", x, PACKAGE = "checkmate")
}
