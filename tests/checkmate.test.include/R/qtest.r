#' @title Re-export of qtest
#' @param x
#'   See \code{link[checkmate]{qtest}}.
#' @param rule
#'   See \code{link[checkmate]{qtest}}.
#' @export
#' @useDynLib checkmate.test.include c_reexported_qtest
reexported_qtest = function(x, rule) {
  .Call(c_reexported_qtest, x, rule)
}
