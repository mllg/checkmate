#' @rdname anyMissing
#' @useDynLib checkmate c_all_missing
#' @export
#' @examples
#'  x = 1:2
#'  allMissing(x)
#'  x[1] = NA
#'  allMissing(x)
#'  x[2] = NA
#'  allMissing(x)
allMissing = function(x) {
  .Call("c_all_missing", x, PACKAGE = "checkmate")
}
