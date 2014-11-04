#' Check names to comply to specific rules
#'
#'  Similar to \code{\link{checkNamed}} but you can specify the names directly.
#'
#' @templateVar fn Named
#' @param x [\code{character} || \code{NULL}]\cr
#'  Names to check using rules defined via \code{type}.
#' @param type [character(1)]\cr
#'  Select the check(s) to perform.
#'  \dQuote{unnamed} checks \code{x} to be \code{NULL}.
#'  \dQuote{named} (default) checks \code{x} for reguluar names which excludes names to be \code{NA} or emtpy (\code{""}).
#'  \dQuote{unique} additionally tests for non-duplicated names.
#'  \dQuote{strict} checks for unique names which comply to R's variable name restrictions.
#' @template checker
#' @useDynLib checkmate c_check_named
#' @export
#' @examples
#' x = 1:3
#' testNames(x, "unnamed")
#' names(x) = letters[1:3]
#' testNames(x, "unique")
checkNames = function(x, type = "named") {
  .Call("c_check_names", x, type, PACKAGE = "checkmate")
}

#' @rdname checkNames
#' @useDynLib checkmate c_check_names
#' @export
assertNames = function(x, type = "named", .var.name) {
  res = .Call("c_check_names", x, type, PACKAGE = "checkmate")
  makeAssertion(res, vname(x, .var.name))
}

#' @rdname checkNames
#' @useDynLib checkmate c_check_names
#' @export
testNames = function(x, type = "named") {
  isTRUE(.Call("c_check_names", x, type, PACKAGE = "checkmate"))
}
