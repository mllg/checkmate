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
#' @include helper.r
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
#' @param check.fun [\code{function}]\cr
#'  Function which checks the input. Must return \code{TRUE} on success and a string with the error message otherwise.
#' @param env [\code{environment}]\cr
#'  The environment of the created function. Default is the \code{\link[base]{parent.frame}}.
#' @export
makeTestFunction = function(check.fun, env = parent.frame()) {
  fn.name = if (!is.character(check.fun)) deparse(substitute(check.fun)) else check.fun
  check.fun = match.fun(check.fun)

  new.fun = function() TRUE
  formals(new.fun) = formals(check.fun)
  tmpl = "{ isTRUE(%s(%s)) }"
  body(new.fun) = parse(text = sprintf(tmpl, fn.name, paste0(names(formals(check.fun)), collapse = ", ")))
  environment(new.fun) = env
  return(new.fun)
}
