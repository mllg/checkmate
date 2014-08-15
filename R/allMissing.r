#' @rdname anyMissing
#' @useDynLib checkmate c_all_missing
#' @export
#' @examples
#' allMissing(1:2)
#' allMissing(c(1, NA))
#' allMissing(c(NA, NA))
allMissing = function(x) {
  .Call("c_all_missing", x, PACKAGE = "checkmate")
}
