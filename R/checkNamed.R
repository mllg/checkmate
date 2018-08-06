#' Check if an argument is named
#'
#' @templateVar fn Named
#' @template x
#' @param type [character(1)]\cr
#'  Select the check(s) to perform.
#'  \dQuote{unnamed} checks \code{x} to be unnamed.
#'  \dQuote{named} (default) checks \code{x} to be named which excludes names to be \code{NA} or empty (\code{""}).
#'  \dQuote{unique} additionally tests for non-duplicated names.
#'  \dQuote{strict} checks for unique names which comply to R's variable name restrictions.
#'  Note that for zero-length \code{x} every name check evaluates to \code{TRUE}.
#' @template checker
#' @note
#' These function are deprecated and will be removed in a future version.
#' Please use \code{\link{checkNames}} instead.
#' @useDynLib checkmate c_check_named
#' @family attributes
#' @export
#' @examples
#' x = 1:3
#' testNamed(x, "unnamed")
#' names(x) = letters[1:3]
#' testNamed(x, "unique")
checkNamed = function(x, type = "named") {
  .Deprecated(new = "checkNames", old = "checkNamed", package = "checkmate")
  .Call(c_check_named, x, type)
}

#' @export
#' @rdname checkNamed
check_named = checkNamed

#' @export
#' @include makeAssertion.R
#' @template assert
#' @rdname checkNamed
assertNamed = makeAssertionFunction(checkNamed, c.fun = "c_check_named", use.namespace = FALSE)

#' @export
#' @rdname checkNamed
assert_named = assertNamed

#' @export
#' @include makeTest.R
#' @rdname checkNamed
testNamed = makeTestFunction(checkNamed, c.fun = "c_check_named")

#' @export
#' @rdname checkNamed
test_named = testNamed

# This function is already provided by testthat
# #' @export
# #' @include makeExpectation.R
# #' @template expect
# #' @rdname checkNamed
expect_named = makeExpectationFunction(checkNamed, c.fun = "c_check_named", use.namespace = FALSE)
