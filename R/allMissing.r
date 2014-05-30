#' @rdname anyMissing
#' @useDynLib checkmate c_all_missing
#' @export
allMissing = function(x) {
  .Call("c_all_missing", x, PACKAGE = "checkmate")
}
