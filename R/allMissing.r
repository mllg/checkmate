#' @useDynLib checkmate c_all_missing
#' @rdname anyMissing
#' @export
allMissing = function(x) {
  .Call("c_all_missing", x, PACKAGE = "checkmate")
}
