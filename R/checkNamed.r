#' Check if an argument is named
#'
#' @templateVar fn Named
#' @template checker
#' @param type [character(1)]\cr
#'  Select the check(s) to perform.
#'  \dQuote{unnamed} checks \code{x} to be unnamed.
#'  \dQuote{named} (default) checks \code{x} to be named, this includes names to be not \code{NA} or emtpy (\code{""}).
#'  \dQuote{unique} additionally tests for non-duplicated names.
#'  Note that for zero-length \code{x} every name check evalutes to \code{TRUE}.
#' @useDynLib checkmate c_check_named
#' @export
#' @examples
#'  x = 1:3
#'  testNamed(x, "unnamed")
#'  names(x) = letters[1:3]
#'  testNamed(x, "unique")
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
  isTRUE(
    .Call("c_check_named", x, type, PACKAGE = "checkmate")
  )
}
