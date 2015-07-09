#' Check if an argument is named
#'
#' @templateVar fn Named
#' @template x
#' @param type [character(1)]\cr
#'  Select the check(s) to perform.
#'  \dQuote{unnamed} checks \code{x} to be unnamed.
#'  \dQuote{named} (default) checks \code{x} to be named which excludes names to be \code{NA} or emtpy (\code{""}).
#'  \dQuote{unique} additionally tests for non-duplicated names.
#'  \dQuote{strict} checks for unique names which comply to R's variable name restrictions.
#'  Note that for zero-length \code{x} every name check evalutes to \code{TRUE}.
#'  Also note that you can use \code{\link{checkSubset}} to check for a specific set of names.
#' @template checker
#' @useDynLib checkmate c_check_named
#' @export
#' @examples
#' x = 1:3
#' testNamed(x, "unnamed")
#' names(x) = letters[1:3]
#' testNamed(x, "unique")
checkNamed = function(x, type = "named") {
  .Call("c_check_named", x, type, PACKAGE = "checkmate")
}

#' @rdname checkNamed
#' @useDynLib checkmate c_check_named
#' @export
assertNamed = function(x, type = "named", .var.name) {
  res = .Call("c_check_named", x, type, PACKAGE = "checkmate")
  makeAssertion(res, vname(x, .var.name))
}

#' @rdname checkNamed
#' @useDynLib checkmate c_check_named
#' @export
testNamed = function(x, type = "named") {
  res = .Call("c_check_named", x, type, PACKAGE = "checkmate")
  isTRUE(res)
}

# #' @rdname checkNamed
# #' @useDynLib checkmate c_check_named
# #' @template expect
# #' @export
# expect_named = function(x, type = "named", info = NULL, label = NULL) {
#   res = .Call("c_check_named", x, type, PACKAGE = "checkmate")
#   makeExpectation(res, info = info, label = vname(x, label))
# }
