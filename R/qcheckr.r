#' Check list elements or data frame columns against rules
#'
#' @param x [\code{list} or \code{data.frame}]\cr
#'   List elements or data frame columns to check against \code{rules}.
#'   See \code{\link{qcheck}} for rule explanation.
#' @param rules [\code{character}]\cr
#'   Set of rules. See \code{\link{qcheck}}
#' @return [logical(1)]: \code{TRUE} if each element of \code{x} complies
#'   at least one rule. Otherwise \code{FALSE} or an exception is thrown.
#' @seealso \code{\link{qcheck}}, \code{\link{qassert}}
#' @export
#' @useDynLib checkmate c_qcheck
#' @examples
#' qcheckr(as.list(1:10), "i+")
#' qassert(iris, "n")
qcheckr = function(x, rules) {
  .Call("c_qcheck", x, rules, TRUE, PACKAGE = "checkmate")
}
