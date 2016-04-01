#' @rdname anyMissing
#' @useDynLib checkmate c_all_missing
#' @export
#' @examples
#' allMissing(1:2)
#' allMissing(c(1, NA))
#' allMissing(c(NA, NA))
#' x = data.frame(a = 1:2, b = NA)
#' # Note how allMissing combines the results for data frames:
#' allMissing(x)
#' all(sapply(x, allMissing))
allMissing = function(x) {
  .Call(c_all_missing, x)
}
