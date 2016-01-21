#' Check if an argument is a vector of type logical
#'
#' @templateVar fn Logical
#' @template x
#' @template na-handling
#' @inheritParams checkVector
#' @template checker
#' @family basetypes
#' @useDynLib checkmate c_check_logical
#' @export
#' @examples
#' testLogical(TRUE)
#' testLogical(TRUE, min.len = 1)
checkLogical = function(x, any.missing = TRUE, all.missing = TRUE, len = NULL, min.len = NULL, max.len = NULL, unique = FALSE, names = NULL) {
  .Call(c_check_logical, x, any.missing, all.missing, len, min.len, max.len, unique, names)
}

#' @export
#' @include makeAssertion.r
#' @template assert
#' @rdname checkLogical
assertLogical = makeAssertionFunction(checkLogical)

#' @export
#' @rdname checkLogical
assert_logical = assertLogical

#' @export
#' @include makeTest.r
#' @rdname checkLogical
testLogical = makeTestFunction(checkLogical)

#' @export
#' @rdname checkLogical
test_logical = testLogical

#' @export
#' @include makeExpectation.r
#' @template expect
#' @rdname checkLogical
expect_logical = makeExpectationFunction(checkLogical)
