#' @title Quick recursive arguments checks on lists and data frames
#'
#' @description
#' These functions are the tuned counterparts of \code{\link{qtest}},
#' \code{\link{qassert}} and \code{\link{qexpect}} tailored for recursive
#' checks of list elements or data frame columns.
#'
#' @param x [\code{list} or \code{data.frame}]\cr
#'   List or data frame to check for compliance with at least one of \code{rules}.
#'   See details of \code{\link{qtest}} for rule explanation.
#' @param rules [\code{character}]\cr
#'   Set of rules. See \code{\link{qtest}}
#' @param .var.name [\code{logical(1)}]\cr
#'  Argument name to print in error message. If missing,
#'  the name of \code{x} will be retrieved via \code{\link[base]{substitute}}.
#' @return See \code{\link{qassert}}.
#' @seealso \code{\link{qtest}}, \code{\link{qassert}}
#' @useDynLib checkmate c_qassert
#' @export
#' @examples
#' # All list elements are integers with length >= 1?
#' qtestr(as.list(1:10), "i+")
#'
#' # All list elements (i.e. data frame columns) are numeric?
#' qtestr(iris, "n")
#'
#' # All list elements are numeric, w/o NAs?
#' qtestr(list(a = 1:3, b = rnorm(1), c = letters), "N+")
#'
#' # All list elements are numeric OR character
#' qtestr(list(a = 1:3, b = rnorm(1), c = letters), c("N+", "S+"))
qassertr = function(x, rules, .var.name) {
  res = .Call(c_qassert, x, rules, TRUE)
  if (!isTRUE(res))
    mstop(qamsg(x, res, .var.name, recursive = TRUE))
  invisible(x)
}

#' @rdname qassertr
#' @useDynLib checkmate c_qtest
#' @export
qtestr = function(x, rules) {
  .Call(c_qtest, x, rules, TRUE)
}

#' @rdname qassertr
#' @template expect
#' @include makeExpectation.r
#' @useDynLib checkmate c_qassert
#' @export
qexpectr = function(x, rules, info = NULL, label = NULL) {
  res = .Call(c_qassert, x, rules, TRUE)
  makeExpectation(x, res, info = info, label = label)
}
