#' Check if an argument is a flag
#'
#' @description
#' A flag is defined as single logical value.
#'
#' @templateVar fn Flag
#' @template x
#' @template na-handling
#' @template na.ok
#' @template null.ok
#' @template checker
#' @family scalars
#' @useDynLib checkmate c_check_flag
#' @export
#' @examples
#' testFlag(TRUE)
#' testFlag(1)
checkFlag = function(x, na.ok = FALSE, null.ok = FALSE) {
  .Call(c_check_flag, x, na.ok, null.ok)
}

#' @export
#' @rdname checkFlag
check_flag = checkFlag

#' @export
#' @include makeAssertion.R
#' @template assert
#' @rdname checkFlag
assertFlag = makeAssertionFunction(checkFlag, c.fun = "c_check_flag")

#' @export
#' @rdname checkFlag
assert_flag = assertFlag

#' @export
#' @include makeTest.R
#' @rdname checkFlag
testFlag = makeTestFunction(checkFlag, c.fun = "c_check_flag")

#' @export
#' @rdname checkFlag
test_flag = testFlag

#' @export
#' @include makeExpectation.R
#' @template expect
#' @rdname checkFlag
expect_flag = makeExpectationFunction(checkFlag, c.fun = "c_check_flag")
