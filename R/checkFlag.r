#' Check if an argument is a flag
#'
#' @description
#' A flag is defined as single logical value.
#'
#' @templateVar fn Flag
#' @template x
#' @template na-handling
#' @param na.ok [\code{logical(1)}]\cr
#'  Are missing values allowed? Default is \code{FALSE}.
#' @template checker
#' @family scalars
#' @useDynLib checkmate c_check_flag
#' @export
#' @examples
#' testFlag(TRUE)
#' testFlag(1)
checkFlag = function(x, na.ok = FALSE) {
  .Call(c_check_flag, x, na.ok)
}

#' @export
#' @include makeAssertion.r
#' @template assert
#' @rdname checkFlag
assertFlag = makeAssertionFunction(checkFlag, c.fun = "c_check_flag")

#' @export
#' @rdname checkFlag
assert_flag = assertFlag

#' @export
#' @include makeTest.r
#' @rdname checkFlag
testFlag = makeTestFunction(checkFlag, c.fun = "c_check_flag")

#' @export
#' @rdname checkFlag
test_flag = testFlag

#' @export
#' @include makeExpectation.r
#' @template expect
#' @rdname checkFlag
expect_flag = makeExpectationFunction(checkFlag, c.fun = "c_check_flag")
