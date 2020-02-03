#' Check if an argument is a vector of type logical
#'
#' @templateVar fn Logical
#' @template x
#' @template na-handling
#' @inheritParams checkVector
#' @template null.ok
#' @template checker
#' @family basetypes
#' @useDynLib checkmate c_check_logical
#' @export
#' @examples
#' testLogical(TRUE)
#' testLogical(TRUE, min.len = 1)
checkLogical = function(x, any.missing = TRUE, all.missing = TRUE, len = NULL, min.len = NULL, max.len = NULL, unique = FALSE, names = NULL, null.ok = FALSE) {
  .Call(c_check_logical, x, any.missing, all.missing, len, min.len, max.len, unique, names, null.ok)
}

#' @export
#' @rdname checkLogical
check_logical = checkLogical

#' @export
#' @include makeAssertion.R
#' @template assert
#' @rdname checkLogical
assertLogical = makeAssertionFunction(checkLogical, c.fun = "c_check_logical", use.namespace = FALSE)

#' @export
#' @rdname checkLogical
assert_logical = assertLogical

#' @export
#' @include makeTest.R
#' @rdname checkLogical
testLogical = makeTestFunction(checkLogical, c.fun = "c_check_logical")

#' @export
#' @rdname checkLogical
test_logical = testLogical

#' @export
#' @include makeExpectation.R
#' @template expect
#' @rdname checkLogical
expect_logical = makeExpectationFunction(checkLogical, c.fun = "c_check_logical", use.namespace = FALSE)
