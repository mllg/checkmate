#' @title Turn a Check into an Expectation
#'
#' @description
#' \code{makeExpectation} is the internal function used to evaluate the result of a
#' check and turn it into an \code{\link[testthat]{expectation}}.
#' \code{makeExceptionFunction} can be used to automatically create an expectation
#' function based on a check function (see example).
#'
#' @template x
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
#' @include helper.r
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
#' # Alternative: Automatically create such a function
#' expect_false = makeExpectationFunction(checkFalse)
#' print(expect_false)
makeExpectation = function(x, res, info = NULL, label = NULL) {
  if (!requireNamespace("testthat", quietly = TRUE))
    stop("Package 'testthat' is required for 'expect_*' extensions")
  cond = function(res) testthat::expectation(isTRUE(res), failure_msg = res, success_msg = "all good")
  testthat::expect_that(res, cond, info = info, label = vname(x, label))
}

#' @rdname makeExpectation
#' @template makeFunction
#' @export
makeExpectationFunction = function(check.fun, c.fun = NULL, env = parent.frame()) {
  fn.name = if (!is.character(check.fun)) deparse(substitute(check.fun)) else check.fun
  check.fun = match.fun(check.fun)

  new.fun = function() TRUE
  formals(new.fun) = c(formals(check.fun), alist(info = NULL, label = NULL))
  tmpl = "{ res = %s(%s); makeExpectation(x, res, info, label) }"
  if (is.null(c.fun)) {
    body(new.fun) = parse(text = sprintf(tmpl, fn.name, paste0(names(formals(check.fun)), collapse = ", ")))
  } else {
    body(new.fun) = parse(text = sprintf(tmpl, ".Call", paste0(c(c.fun, names(formals(check.fun))), collapse = ", ")))
  }
  environment(new.fun) = env
  return(new.fun)
}
