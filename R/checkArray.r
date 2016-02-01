#' Check if an argument is an array
#'
#' @templateVar fn Array
#' @template x
#' @template mode
#' @param any.missing [\code{logical(1)}]\cr
#'  Are missing values allowed? Default is \code{TRUE}.
#' @param d [\code{integer(1)}]\cr
#'  Exact number of dimensions of array \code{x}.
#'  Default is \code{NULL} (no check).
#' @param min.d [\code{integer(1)}]\cr
#'  Minimum number of dimensions of array \code{x}.
#'  Default is \code{NULL} (no check).
#' @param max.d [\code{integer(1)}]\cr
#'  Maximum number of dimensions of array \code{x}.
#'  Default is \code{NULL} (no check).
#' @template checker
#' @family basetypes
#' @useDynLib checkmate c_check_array
#' @export
#' @examples
#' checkArray(array(1:27, dim = c(3, 3, 3)), d = 3)
checkArray = function(x, mode = NULL, any.missing = TRUE, d = NULL, min.d = NULL, max.d = NULL) {
  .Call(c_check_array, x, mode, any.missing, d, min.d, max.d)
}

#' @export
#' @include makeAssertion.r
#' @template assert
#' @rdname checkArray
assertArray = makeAssertionFunction(checkArray, c.fun = "c_check_array")

#' @export
#' @rdname checkArray
assert_array = assertArray

#' @export
#' @include makeTest.r
#' @rdname checkArray
testArray = makeTestFunction(checkArray, c.fun = "c_check_array")

#' @export
#' @rdname checkArray
test_array = testArray

#' @export
#' @include makeExpectation.r
#' @template expect
#' @rdname checkArray
expect_array = makeExpectationFunction(checkArray, c.fun = "c_check_array")
