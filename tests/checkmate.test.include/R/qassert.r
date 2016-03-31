#' @title Re-export of qassert
#' @param x
#'   See \code{link[checkmate]{qassert}}.
#' @param rule
#'   See \code{link[checkmate]{qassert}}.
#' @export
#' @useDynLib checkmate.test.include c_reexported_qassert
reexported_qassert = function(x, rule, var.name = "x") {
  .Call(c_reexported_qassert, x, rule, var.name)
}
