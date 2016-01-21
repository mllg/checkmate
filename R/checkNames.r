#' Check names to comply to specific rules
#'
#' @description
#' Similar to \code{\link{checkNamed}} but you can pass the names directly.
#'
#' @templateVar fn Named
#' @param x [\code{character} || \code{NULL}]\cr
#'  Names to check using rules defined via \code{type}.
#' @param type [character(1)]\cr
#'  Select the check(s) to perform.
#'  \dQuote{unnamed} checks \code{x} to be \code{NULL}.
#'  \dQuote{named} (default) checks \code{x} for regular names which excludes names to be \code{NA} or empty (\code{""}).
#'  \dQuote{unique} additionally tests for non-duplicated names.
#'  \dQuote{strict} checks for unique names which comply to R's variable name restrictions.
#'  Note that you can use \code{\link{checkSubset}} to check for a specific set of names.
#' @template checker
#' @useDynLib checkmate c_check_names
#' @export
#' @examples
#' x = 1:3
#' testNames(x, "unnamed")
#' names(x) = letters[1:3]
#' testNames(x, "unique")
checkNames = function(x, type = "named") {
  .Call(c_check_names, x, type)
}

#' @export
#' @include makeAssertion.r
#' @template assert
#' @rdname checkNames
assertNames = makeAssertionFunction(checkNames)

#' @export
#' @rdname checkNames
assert_names = assertNames

#' @export
#' @include makeTest.r
#' @rdname checkNames
testNames = makeTestFunction(checkNames)

#' @export
#' @rdname checkNames
test_names = testNames

#' @export
#' @include makeExpectation.r
#' @template expect
#' @rdname checkNames
expect_names = makeExpectationFunction(checkNames)
