#' @title Turn a Check into a Test
#'
#' @description
#' \code{makeTest} is the internal function used to evaluate the result of a
#' check and throw an exception if necessary.
#' This function is currently a stub and just calls \code{\link[base]{isTRUE}}.
#' \code{makeTestFunction} can be used to automatically create an assertion
#' function based on a check function (see example).
#'
#' @param res [\code{TRUE} | \code{character(1)}]\cr
#'  The result of a check function: \code{TRUE} for successful checks,
#'  and an error message as string otherwise.
#' @return \code{makeTest} returns \code{TRUE} if the check is successful and \code{FALSE} otherwise.
#'  \code{makeTestFunction} returns a \code{function}.
#' @export
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
#' # Alternative: Automatically create such a function:
#' test = makeTestFunction(checkFalse)
makeTest = function(res) {
  isTRUE(res)
}

#' @rdname makeTest
#' @param check.fun [\code{function}]\cr
#'  Function which checks the input. Must return \code{TRUE} on success and a string with the error message otherwise.
#' @export
makeTestFunction = function(check.fun) {
  TEST_TMPL = "{ isTRUE(check.fun(%s)) }"
  check.fun = match.fun(check.fun)
  new.fun = function() TRUE

  ee = new.env(parent = environment(check.fun))
  ee$check.fun = check.fun
  formals(new.fun) = formals(check.fun)
  body(new.fun) = parse(text = sprintf(TEST_TMPL, paste0(names(formals(check.fun)), collapse = ", ")))
  environment(new.fun) = ee
  new.fun
}
