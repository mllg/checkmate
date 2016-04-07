#' @title Quick argument checks on (builtin) R types
#'
#' @description
#' The provided functions parse rules which allow to express some of the most
#' frequent argument checks by typing just a few letters.
#'
#' @param x [any]\cr
#'  Object the check.
#' @param rules [\code{character}]\cr
#'   Set of rules. See details.
#' @template var.name
#' @return
#'  \code{qassert} throws an \code{R} exception if object \code{x} does
#'  not comply to at least one of the \code{rules} and returns the tested object invisibly
#'  otherwise.
#'  \code{qtest} behaves the same way but returns \code{FALSE} if none of the
#'  \code{rules} comply.
#'  \code{qexpect} is intended to be inside the unit test framework \code{\link[testthat]{testthat}} and
#'  returns an \code{\link[testthat]{expectation}}.
#'
#' @details
#' The rule is specified in up to three parts.
#' \enumerate{
#'  \item{
#'    Class and missingness check.
#'    The first letter is an abbreviation for the class. If it is
#'    provided uppercase, missing values are prohibited.
#'    Supported abbreviations:
#'    \tabular{rl}{
#'      \code{[bB]} \tab Bool / logical.\cr
#'      \code{[iI]} \tab Integer.\cr
#'      \code{[xX]} \tab Integerish (numeric convertible to integer, see \code{\link{checkIntegerish}}).\cr
#'      \code{[rR]} \tab Real / double.\cr
#'      \code{[cC]} \tab Complex.\cr
#'      \code{[nN]} \tab Numeric (integer or double).\cr
#'      \code{[sS]} \tab String / character.\cr
#'      \code{[aA]} \tab Atomic.\cr
#'      \code{[vV]} \tab Atomic vector (see \code{\link{checkAtomicVector}}).\cr
#'      \code{[lL]} \tab List. Missingness is defined as \code{NULL} element.\cr
#'      \code{[mM]} \tab Matrix.\cr
#'      \code{[dD]} \tab Data.frame. Missingness is checked recursively on columns.\cr
#'      \code{[e]}  \tab Environment.\cr
#'      \code{[f]}  \tab Function.\cr
#'      \code{[0]}  \tab \code{NULL}.\cr
#'      \code{[*]}  \tab placeholder to allow any type.
#'    }
#'    Note that the check for missingness does not distinguish between
#'    \code{NaN} and \code{NA}. Infinite values are not treated as missing, but
#'    can be caught using boundary checks (part 3).
#'    }
#'  \item{
#'    Length definition. This can be one of
#'    \tabular{rl}{
#'      \code{[*]} \tab any length,\cr
#'      \code{[?]} \tab length of zero or one,\cr
#'      \code{[+]} \tab length of at least one, or\cr
#'      \code{[0-9]+} \tab exact length specified as integer.
#'    }
#'    Preceding the exact length with one of the comparison operators \code{=}/\code{==},
#'    \code{<}, \code{<=}, \code{>=} or \code{>} is also supported.
#'  }
#'  \item{
#'    Range check as two numbers separated by a comma, enclosed by square brackets
#'    (endpoint included) or parentheses (endpoint excluded).
#'    For example, \dQuote{[0, 3)} results in \code{all(x >= 0 & x < 3)}.
#'    The lower and upper bound may be omitted which is the equivalent of a negative or
#'    positive infinite bound, respectively.
#'    By definition \code{[0,]} contains \code{Inf}, while \code{[0,)} does not.
#'    The same holds for the left (lower) boundary and \code{-Inf}.
#'    E.g., the rule \dQuote{N1()} checks for a single finite numeric which is not NA,
#'    while \dQuote{N1[)} allows \code{-Inf}.
#'  }
#' }
#' @note
#' The functions are inspired by the blog post of Bogumił Kamiński:
#' \url{http://rsnippets.blogspot.de/2013/06/testing-function-agruments-in-gnu-r.html}.
#' The implementation is mostly written in C to minimize the overhead.
#' @seealso \code{\link{qtestr}} and \code{\link{qassertr}} for efficient checks
#' of list elements and data frame columns.
#' @useDynLib checkmate c_qassert
#' @export
#' @examples
#' # logical of length 1
#' qtest(NA, "b1")
#'
#' # logical of length 1, NA not allowed
#' qtest(NA, "B1")
#'
#' # logical of length 0 or 1, NA not allowed
#' qtest(TRUE, "B?")
#'
#' # numeric with length > 0
#' qtest(runif(10), "n+")
#'
#' # integer with length > 0, NAs not allowed, all integers >= 0 and < Inf
#' qtest(1:3, "I+[0,)")
#'
#' # either an emtpy list or a character vector with <=5 elements
#' qtest(1, c("l0", "s<=5"))
#'
#' # data frame with at least one column and no missing value in any column
#' qtest(iris, "D+")
qassert = function(x, rules, .var.name = vname(x)) {
  res = .Call(c_qassert, x, rules, FALSE)
  if (!identical(res, TRUE))
    mstop(qmsg(res, .var.name))
  invisible(x)
}

#' @useDynLib checkmate c_qtest
#' @rdname qassert
#' @export
qtest = function(x, rules) {
  .Call(c_qtest, x, rules, FALSE)
}

#' @useDynLib checkmate c_qassert
#' @template expect
#' @rdname qassert
#' @include makeExpectation.R
#' @export
qexpect = function(x, rules, info = NULL, label = vname(x)) {
  res = .Call(c_qassert, x, rules, FALSE)
  if (!identical(res, TRUE))
    res = qmsg(res, label)
  makeExpectation(x, res, info = info, label = label)
}

qmsg = function(msg, vname) {
  if (length(msg) > 1L)
    msg = paste0(c("One of the following must apply:", strwrap(msg, prefix = " * ")), collapse = "\n")
  sprintf("Assertion on '%s' failed. %s.", vname, msg)
}
