#' @title Check if an object is an integerish vector
#'
#' @description
#' An integerish value is defined as value safely convertible to integer.
#' This includes integers and numeric values which sufficiently close to an
#' integer w.r.t. a numeric tolerance `tol`.
#'
#' @note
#' To convert from integerish to integer, use \code{\link{asInteger}}.
#'
#' @templateVar fn Integerish
#' @template x
#' @template na-handling
#' @inheritParams checkInteger
#' @inheritParams checkVector
#' @template sorted
#' @template tol
#' @template coerce
#' @template typed.missing
#' @template null.ok
#' @template checker
#' @family basetypes
#' @useDynLib checkmate c_check_integerish
#' @export
#' @examples
#' testIntegerish(1L)
#' testIntegerish(1.)
#' testIntegerish(1:2, lower = 1L, upper = 2L, any.missing = FALSE)
checkIntegerish = function(x, tol = sqrt(.Machine$double.eps), lower = -Inf, upper = Inf, any.missing = TRUE, all.missing = TRUE, len = NULL, min.len = NULL, max.len = NULL, unique = FALSE, sorted = FALSE, names = NULL, typed.missing = FALSE, null.ok = FALSE) {
  .Call(c_check_integerish, x, tol, lower, upper, any.missing, all.missing, len, min.len, max.len, unique, sorted, names, typed.missing, null.ok)
}

#' @export
#' @rdname checkIntegerish
check_integerish = checkIntegerish

#' @export
#' @include makeAssertion.R
#' @template assert
#' @rdname checkIntegerish
assertIntegerish = makeAssertionFunction(checkIntegerish, c.fun = "c_check_integerish", use.namespace = FALSE, coerce = TRUE)

#' @export
#' @rdname checkIntegerish
assert_integerish = assertIntegerish

#' @export
#' @include makeTest.R
#' @rdname checkIntegerish
testIntegerish = makeTestFunction(checkIntegerish, c.fun = "c_check_integerish")

#' @export
#' @rdname checkIntegerish
test_integerish = testIntegerish

#' @export
#' @include makeExpectation.R
#' @template expect
#' @rdname checkIntegerish
expect_integerish = makeExpectationFunction(checkIntegerish, c.fun = "c_check_integerish", use.namespace = FALSE)
