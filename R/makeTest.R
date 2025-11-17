#' @title Turn a Check into a Test
#'
#' @description
#' \code{makeTest} is the internal function used to evaluate the result of a
#' check and throw an exception if necessary.
#' This function is currently only a stub and just calls \code{\link[base]{isTRUE}}.
#' \code{makeTestFunction} can be used to automatically create an assertion
#' function based on a check function (see example).
#'
#' @param res [\code{TRUE} | \code{character(1)}]\cr
#'  The result of a check function: \code{TRUE} for successful checks,
#'  and an error message as string otherwise.
#' @return \code{makeTest} returns \code{TRUE} if the check is successful and \code{FALSE} otherwise.
#'  \code{makeTestFunction} returns a \code{function}.
#' @export
#' @family CustomConstructors
#' @include helper.R
#' @examples
#' # Simple custom check function
#' checkFalse = function(x) if (!identical(x, FALSE)) "Must be FALSE" else TRUE
#'
#' # Create the respective test function
#' testFalse = function(x) {
#'   res = checkFalse(x)
#'   makeTest(res)
#' }
#'
#' # Alternative: Automatically create such a function
#' testFalse = makeTestFunction(checkFalse)
#' print(testFalse)
makeTest = function(res) {
  isTRUE(res)
}

#' @rdname makeTest
#' @template makeFunction
#' @include makeXFunction.R
#' @export
makeTestFunction = makeXFunctionFactory("test")
