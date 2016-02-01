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
  .Call(c_check_named, x, type)
}

#' @export
#' @include makeAssertion.r
#' @template assert
#' @rdname checkNamed
assertNamed = makeAssertionFunction(checkNamed, c.fun = "c_check_named")

#' @export
#' @rdname checkNamed
assert_named = assertNamed

#' @export
#' @include makeTest.r
#' @rdname checkNamed
testNamed = makeTestFunction(checkNamed, c.fun = "c_check_named")

#' @export
#' @rdname checkNamed
test_named = testNamed

# This function is already provided by testthat
# #' @export
# #' @include makeExpectation.r
# #' @template expect
# #' @rdname checkNamed
expect_named = makeExpectationFunction(checkNamed, c.fun = "c_check_named")
