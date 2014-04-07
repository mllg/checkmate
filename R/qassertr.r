#' Recursive arguments checks on lists and data frames.
#'
#' These functions are the tuned counterparts of \code{\link{qcheck}} and
#' \code{\link{qassert}} tailored for recursive checks of list
#' elements or data frame columns.
#'
#' @param x [\code{list} or \code{data.frame}]\cr
#'   List or data frame to check for compliance with at least one of \code{rules}.
#'   See details of \code{\link{qcheck}} for rule explanation.
#' @param rules [\code{character}]\cr
#'   Set of rules. See \code{\link{qcheck}}
#' @param .var.name [\code{logical(1)}]\cr
#'  Argument name to print in error message. If missing,
#'  the name of \code{x} will be retrieved via \code{\link[base]{substitute}}.
#' @return [logical(1)]: \code{TRUE} on success, \code{FALSE} (or a thrown exception) otherwise.
#' @seealso \code{\link{qcheck}}, \code{\link{qassert}}
#' @export
#' @useDynLib checkmate c_qassert
#' @examples
#' qcheckr(as.list(1:10), "i+")
#' qcheck(iris, "n")
qassertr = function(x, rules, .var.name) {
  res = .Call("c_qassert", x, rules, TRUE, PACKAGE = "checkmate")
  qamsg(res, vname(x, .var.name))
}


#' @export
#' @rdname qassertr
#' @useDynLib checkmate c_qcheck
qcheckr = function(x, rules) {
  .Call("c_qcheck", x, rules, TRUE, PACKAGE = "checkmate")
}
