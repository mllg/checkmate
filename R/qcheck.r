#' Check arguments against rules
#'
#' This functions check an R object \code{x} against a set of rules.
#' This allows to do frequent argument checks with less typing
#' at a considerable performance.
#' If the object complies to at least one of the specified rule, \code{TRUE} is returned.
#' Otherwise \code{qcheck} returns \code{FALSE} \code{qassert} throws an exception.
#' The rule to check \code{x} against must be given in the simple format \dQuote{[type][length]}.
#'
#' @param x [ANY]\cr
#'  Object the check.
#' @param rules [\code{character}]\cr
#'   Set of rules. See details.
#' @return \code{TRUE} if \code{x} complies to one of \code{rules}, \code{FALSE} or an
#'   exception if thrown otherwise.
#'
#' @details
#' The rule is specified in two parts. The first letter defines the expected type.
#' If given uppercase, an additional check for missingness is performed.
#' Note that missingness is defined as \code{NA} or \code{NaN} for
#' numeric types and \code{NULL} for lists.
#' \tabular{rl}{
#'   \code{[bB]} \tab Checks for type bool / logical.\cr
#'   \code{[iI]} \tab Checks for type integer.\cr
#'   \code{[rR]} \tab Checks for type real / double.\cr
#'   \code{[cC]} \tab Checks for type complex.\cr
#'   \code{[nN]} \tab Checks for type numeric (integer or double).\cr
#'   \code{[sS]} \tab Checks for type string (character).\cr
#'   \code{[aA]} \tab Checks for type atomic.\cr
#'   \code{[lL]} \tab Checks for type list..\cr
#'   \code{[mM]} \tab Checks for type matrix.\cr
#'   \code{[dD]} \tab Checks for type data.frame.\cr
#'   \code{[e]} \tab Checks for type environment.\cr
#'   \code{[f]} \tab Checks for type function\cr
#'   \code{[0]} \tab Checks for \code{NULL}.\cr
#'   \code{[*]} \tab Placeholder to allow any type.
#' }
#' The second optional part specifies the expected length:
#' \tabular{rl}{
#' \code{[*]} \tab Any length.\cr
#' \code{[?]} \tab Length of zero or one.\cr
#' \code{[+]} \tab Length of at least one.\cr
#' \code{[0-9]+} \tab Exact length given as integer.
#'   Can be prefixed with one of \dQuote{<}, \dQuote{<=}, \dQuote{>}, \dQuote{>=},
#'   \dQuote{=} or \dQuote{==}.
#' }
#' @note
#' The functions are inspired by the blog post of Bogumił Kamiński:
#' \url{http://rsnippets.blogspot.de/2013/06/testing-function-agruments-in-gnu-r.html}.
#' The functionallity is slightly modified and expanded to check more types.
#' The implementation is written in \code{C} to minimize the overhead.
#' @seealso \code{\link{qcheckr}} and \code{\link{qassertr}} for checking list elements
#'   and data frame columns.
#' @useDynLib checkmate c_qcheck
#' @export
#' @examples
#' qcheck(NA, "b1")
#' qcheck(NA, "B1")
#' qcheck(TRUE, "B?")
#' qcheck(runif(10), "n+")
qcheck = function(x, rules) {
  .Call("c_qcheck", x, rules, FALSE, PACKAGE = "checkmate")
}
