#' Check if an object is an integerish vector
#'
#' @templateVar fn Integerish
#' @template x
#' @template na-handling
#' @inheritParams checkInteger
#' @inheritParams checkVector
#' @template tol
#' @template checker
#' @family basetypes
#' @useDynLib checkmate c_check_integerish
#' @export
#' @examples
#' testIntegerish(1L)
#' testIntegerish(1.)
#' testIntegerish(1:2, lower = 1L, upper = 2L, any.missing = FALSE)
checkIntegerish = function(x, tol = sqrt(.Machine$double.eps), lower = -Inf, upper = Inf, any.missing = TRUE, all.missing = TRUE, len = NULL, min.len = NULL, max.len = NULL, unique = FALSE, names = NULL) {
  .Call(c_check_integerish, x, tol, lower, upper, any.missing, all.missing, len, min.len, max.len, unique, names)
}

#' @export
#' @include makeAssertion.r
#' @template assert
#' @rdname checkIntegerish
assertIntegerish = makeAssertionFunction(checkIntegerish)

#' @export
#' @rdname checkIntegerish
assert_integerish = assertIntegerish

#' @export
#' @include makeTest.r
#' @rdname checkIntegerish
testIntegerish = makeTestFunction(checkIntegerish)

#' @export
#' @rdname checkIntegerish
test_integerish = testIntegerish

#' @export
#' @include makeExpectation.r
#' @template expect
#' @rdname checkIntegerish
expect_integerish = makeExpectationFunction(checkIntegerish)
