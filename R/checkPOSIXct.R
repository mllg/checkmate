#' @title Check that an argument is a date/time object in POSIXct format
#'
#' @description
#' Checks that an object is of class \code{\link[base]{POSIXct}}.
#'
#' @templateVar fn Atomic
#' @template x
#' @param lower [\code{\link[base]{Date}}]\cr
#'  All non-missing dates in \code{x} must be >= this POSIXct time. Must be provided in the same timezone as \code{x}.
#' @param upper [\code{\link[base]{Date}}]\cr
#'  All non-missing dates in \code{x} must be <= this POSIXct time. Must be provided in the same timezone as \code{x}.
#' @template sorted
#' @template null.ok
#' @inheritParams checkVector
#' @template checker
#' @family basetypes
#' @export
#' @useDynLib checkmate c_check_posixct
#' @export
checkPOSIXct = function(x, lower = NULL, upper = NULL, any.missing = TRUE, all.missing = TRUE, len = NULL, min.len = NULL, max.len = NULL, unique = FALSE, sorted = FALSE, null.ok = FALSE) {
  .Call(c_check_posixct, x, lower, upper, any.missing, all.missing, len, min.len, max.len, unique, sorted, null.ok)
}

#' @export
#' @rdname checkPOSIXct
check_posixct = checkPOSIXct

#' @export
#' @include makeAssertion.R
#' @template assert
#' @rdname checkPOSIXct
assertPOSIXct = makeAssertionFunction(checkPOSIXct, c.fun = "c_check_posixct", use.namespace = FALSE)

#' @export
#' @rdname checkPOSIXct
assert_posixct = assertPOSIXct

#' @export
#' @include makeTest.R
#' @rdname checkPOSIXct
testPOSIXct = makeTestFunction(checkPOSIXct, c.fun = "c_check_posixct")

#' @export
#' @rdname checkPOSIXct
test_posixct = testPOSIXct

#' @export
#' @include makeExpectation.R
#' @template expect
#' @rdname checkPOSIXct
expect_posixct = makeExpectationFunction(checkPOSIXct, c.fun = "c_check_posixct", use.namespace = FALSE)
