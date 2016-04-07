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
#' @template var.name
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
qassertr = function(x, rules, .var.name = vname(x)) {
  res = .Call(c_qassert, x, rules, TRUE, 1L)
  if (!identical(res, TRUE))
    mstop(qrmsg(x, res, .var.name))
  invisible(x)
}

#' @rdname qassertr
#' @param depth [\code{integer(1)}]\cr
#'   Maximum recursion depth. Defaults to \dQuote{1} to directly check list elements or
#'   data frame columns. Set to a higher value to check lists of lists of elements.
#' @useDynLib checkmate c_qtest
#' @export
qtestr = function(x, rules, depth = 1L) {
  .Call(c_qtest, x, rules, TRUE, depth)
}

#' @rdname qassertr
#' @template expect
#' @include makeExpectation.R
#' @useDynLib checkmate c_qassert
#' @export
qexpectr = function(x, rules, info = NULL, label = vname(x)) {
  res = .Call(c_qassert, x, rules, TRUE, 1L)
  if (!identical(res, TRUE))
    res = qrmsg(x, res, label)
  makeExpectation(x, res, info = info, label = label)
}

qrmsg = function(x, msg, var.name) {
  pos = attr(msg, "pos")
  if (testNamed(x)) {
    item = sprintf(", element '%s' (%i),", names(x)[pos], pos)
  } else {
    item = sprintf(", element %i,", pos)
  }
  if (length(msg) > 1L)
    msg = paste0(c("One of the following must apply:", strwrap(msg, prefix = " * ")), collapse = "\n")
  sprintf("Assertion on '%s'%s failed. %s.", var.name, item, msg)
}
