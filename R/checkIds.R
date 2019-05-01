#' Check strings to be regular identifiers
#'
#' @description
#' Similar to \code{\link{checkNames}}, but more geared towards string identifiers.
#' Valid Ids are non-empty strings complying to the regular expression pattern
#' \dQuote{^[.]*[a-zA-Z]+[a-zA-Z0-9._]*$}. This ensures that such ids can safely be
#' used as variable names, column names or in formulas.
#'
#' @templateVar fn Ids
#' @param x [\code{character} || \code{NULL}]\cr
#'  Ids to check.
#' @param unique [logical(1)]\cr
#'  Must the ids be unique? Default is \code{FALSE}.
#' @param min.len [integer(1)]\cr
#'  Minimum length.
#' @param len [integer(1)]\cr
#'  Exact length.
#' @template checker
#' @useDynLib checkmate c_check_ids
#' @family attributes
#' @export
#' @examples
#' x = c("foo", "bar")
#' checkIds(x)
#'
#' checkIds(c(x, x), unique = TRUE)
checkIds = function(x, unique = FALSE, len = NULL, min.len = NULL) {
  .Call(c_check_ids, x, unique, len, min.len)
}


#' @export
#' @rdname checkIds
check_ids = checkIds

#' @export
#' @include makeAssertion.R
#' @template assert
#' @rdname checkIds
assertIds = makeAssertionFunction(checkIds, use.namespace = FALSE)

#' @export
#' @rdname checkIds
assert_ids = assertIds

#' @export
#' @include makeTest.R
#' @rdname checkIds
testIds = makeTestFunction(checkIds)

#' @export
#' @rdname checkIds
test_ids = testIds

#' @export
#' @include makeExpectation.R
#' @template expect
#' @rdname checkIds
expect_ids = makeExpectationFunction(checkIds, use.namespace = FALSE)
