#' Check if an argument is vector of type integer
#'
#' @templateVar fn Integer
#' @template x
#' @template na-handling
#' @inheritParams checkVector
#' @template bounds
#' @template checker
#' @family basetypes
#' @seealso \code{\link{asInteger}}
#' @useDynLib checkmate c_check_integer
#' @export
#' @examples
#' testInteger(1L)
#' testInteger(1.)
#' testInteger(1:2, lower = 1, upper = 2, any.missing = FALSE)
checkInteger = function(x, lower = -Inf, upper = Inf, any.missing = TRUE, all.missing = TRUE, len = NULL, min.len = NULL, max.len = NULL, unique = FALSE, names = NULL) {
  .Call(c_check_integer, x, lower, upper, any.missing, all.missing, len, min.len, max.len, unique, names)
}

#' @export
#' @include makeAssertion.r
#' @template assert
#' @rdname checkInteger
assertInteger = makeAssertionFunction(checkInteger)

#' @export
#' @rdname checkInteger
assert_integer = assertInteger

#' @export
#' @include makeTest.r
#' @rdname checkInteger
testInteger = makeTestFunction(checkInteger)

#' @export
#' @rdname checkInteger
test_integer = testInteger

#' @export
#' @include makeExpectation.r
#' @template expect
#' @rdname checkInteger
expect_integer = makeExpectationFunction(checkInteger)
