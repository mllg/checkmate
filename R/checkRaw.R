#' Check if an argument is a raw vector
#'
#' @templateVar fn Raw
#' @template x
#' @param len [\code{integer(1)}]\cr
#'  Exact expected length of \code{x}.
#' @param min.len [\code{integer(1)}]\cr
#'  Minimal length of \code{x}.
#' @param max.len [\code{integer(1)}]\cr
#'  Maximal length of \code{x}.
#' @param names [\code{character(1)}]\cr
#'  Check for names. See \code{\link{checkNamed}} for possible values.
#'  Default is \dQuote{any} which performs no check at all.
#'  Note that you can use \code{\link{checkSubset}} to check for a specific set of names.
#' @template null.ok
#' @template checker
#' @family basetypes
#' @useDynLib checkmate c_check_raw
#' @export
#' @examples
#' testRaw(as.raw(2), min.len = 1L)
checkRaw = function(x, len = NULL, min.len = NULL, max.len = NULL, names = NULL, null.ok = FALSE) {
  .Call(c_check_raw, x, len, min.len, max.len, names, null.ok)
}

#' @export
#' @rdname checkRaw
check_raw = checkRaw

#' @export
#' @include makeAssertion.R
#' @template assert
#' @rdname checkRaw
assertRaw = makeAssertionFunction(checkRaw, c.fun = "c_check_raw", use.namespace = FALSE)

#' @export
#' @rdname checkRaw
assert_raw = assertRaw

#' @export
#' @include makeTest.R
#' @rdname checkRaw
testRaw = makeTestFunction(checkRaw, c.fun = "c_check_raw")

#' @export
#' @rdname checkRaw
test_raw = testRaw

#' @export
#' @include makeExpectation.R
#' @template expect
#' @rdname checkRaw
expect_raw = makeExpectationFunction(checkRaw, c.fun = "c_check_raw", use.namespace = FALSE)
