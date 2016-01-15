#' @title Turn a Check into an Expectation
#'
#' @description
#' \code{makeExpectation} is the internal function used to evaluate the result of a
#' check and turn it into an \code{\link[testthat]{expectation}}.
#' \code{makeExceptionFunction} can be used to automatically create an expectation
#' function based on a check function (see example).
#'
#' @param res [\code{TRUE} | \code{character(1)}]\cr
#'  The result of a check function: \code{TRUE} for successful checks,
#'  and an error message as string otherwise.
#' @param info [\code{character(1)}]\cr
#'   See \code{\link[testthat]{expect_that}}
#' @param label [\code{character(1)}]\cr
#'   See \code{\link[testthat]{expect_that}}
#' @return \code{makeExpectation} returns the expectation result.
#'  \code{makeExpectationFunction} returns a \code{function}.
#' @export
#' @examples
#' # Simple custom check function
#' checkFalse = function(x) if (!identical(x, FALSE)) "Must be FALSE" else TRUE
#'
#' # Create the respective expect function
#' expect_false = function(x, info = NULL, label = NULL) {
#'   res = checkFalse(x)
#'   makeExpectation(res, info = info, label = label)
#' }
#'
#' # Alternative: Automatically create such a function:
#' expect_false = makeExpectationFunction(checkFalse)
makeExpectation = function(res, info, label) {
  if (!requireNamespace("testthat", quietly = TRUE))
    stop("Package 'testthat' is required for 'expect_*' extensions")
  cond = function(tmp) testthat::expectation(isTRUE(res), failure_msg = res, success_msg = "all good")
  testthat::expect_that(TRUE, cond, info = info, label = vname(res, label))
}

#' @rdname makeExpectation
#' @param check.fun [\code{function}]\cr
#'  Function which checks the input. Must return \code{TRUE} on success and a string with the error message otherwise.
#' @export
makeExpectationFunction = function(check.fun) {
  EXPECT_TMPL = "{ res = check.fun(%s); makeExpectation(res, info = info, label = label) }"
  check.fun = match.fun(check.fun)
  new.fun = function() TRUE

  ee = new.env(parent = environment(check.fun))
  ee$check.fun = check.fun
  formals(new.fun) = c(formals(check.fun), alist(info = NULL, label = NULL))
  body(new.fun) = parse(text = sprintf(EXPECT_TMPL, paste0(names(formals(check.fun)), collapse = ", ")))
  environment(new.fun) = ee
  new.fun
}
