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
#' @return \code{makeExpectation} invisibly returns the checked object.
#'   \code{makeExpectationFunction} returns a \code{function}.
#' @export
#' @family CustomConstructors
#' @include helper.R
#' @examples
#' # Simple custom check function
#' checkFalse = function(x) if (!identical(x, FALSE)) "Must be FALSE" else TRUE
#'
#' # Create the respective expect function
#' expect_false = function(x, info = NULL, label = vname(x)) {
#'   res = checkFalse(x)
#'   makeExpectation(x, res, info = info, label = label)
#' }
#'
#' # Alternative: Automatically create such a function
#' expect_false = makeExpectationFunction(checkFalse)
#' print(expect_false)
makeExpectation = function(x, res, info, label) {
  if (!requireNamespace("testthat", quietly = TRUE))
    stop("Package 'testthat' is required for checkmate's 'expect_*' extensions")
  info = if (is.null(info)) res else sprintf("%s\nAdditional info: %s", res, info)
  testthat::expect_true(res, info = info, label = sprintf("Check on %s", label))
  invisible(x)
}

#' @rdname makeExpectation
#' @template makeFunction
#' @template use.namespace
#' @export
makeExpectationFunction = function(check.fun, c.fun = NULL, use.namespace = FALSE, env = parent.frame()) {
  fun.name = if (!is.character(check.fun)) deparse(substitute(check.fun)) else check.fun
  check.fun = match.fun(check.fun)
  check.args = fun.args = formals(args(check.fun))
  x.name = names(fun.args[1L])
  x = NULL

  new.fun = function() TRUE
  body = sprintf("if (missing(%s)) stop(sprintf(\"Argument '%%s' is missing\", label))", x.name)

  if (is.null(c.fun)) {
    body = paste0(body, sprintf("; res = %s(%s)", fun.name, paste0(names(check.args), collapse = ", ")))
  } else {
    body = paste0(body, sprintf("; res = .Call(%s)", paste0(c(c.fun, names(check.args)), collapse = ", ")))
  }

  if (use.namespace) {
    formals(new.fun) = c(fun.args, alist(info = NULL, label = checkmate::vname(x)))
    body = paste0(body, "; checkmate::makeExpectation")
  } else {
    formals(new.fun) = c(fun.args, alist(info = NULL, label = vname(x)))
    body = paste0(body, "; makeExpectation")
  }
  body = paste0(body, sprintf("(%s, res, info, label)", x.name))

  body(new.fun) = parse(text = paste("{", body, "}"))
  environment(new.fun) = env
  return(new.fun)
}
