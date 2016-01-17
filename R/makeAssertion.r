#' @title Turn a Check into an Assertion
#'
#' @description
#' \code{makeAssertion} is the internal function used to evaluate the result of a
#' check and throw an exception if necessary.
#' \code{makeAssertionFunction} can be used to automatically create an assertion
#' function based on a check function (see example).
#'
#' @template x
#' @param res [\code{TRUE} | \code{character(1)}]\cr
#'  The result of a check function: \code{TRUE} for successful checks,
#'  and an error message as string otherwise.
#' @param var.name [\code{character(1)}]\cr
#'  The custom name for \code{x} as passed to any \code{assert*} function.
#' @param collection [\code{\link{AssertCollection}}]\cr
#'  If an \code{\link{AssertCollection}} is provided, the error message is stored
#'  in it. If \code{NULL} (default), an exception is raised if \code{res} is not
#'  \code{TRUE}.
#' @return \code{makeAssertion} invisibly returns the checked object if the check was successful,
#'  and an exception is raised (or its message stored in the collection) otherwise.
#'  \code{makeAssertionFunction} returns a \code{function}.
#' @export
#' @include helper.r
#' @examples
#' # Simple custom check function
#' checkFalse = function(x) if (!identical(x, FALSE)) "Must be FALSE" else TRUE
#'
#' # Create the respective assert function
#' assertFalse = function(x, add = NULL, .var.name) {
#'   res = checkFalse(x)
#'   makeAssertion(x, res, .var.name, add)
#' }
#'
#' # Alternative: Automatically create such a function
#' assertFalse = makeAssertionFunction(checkFalse)
#' print(assertFalse)
makeAssertion = function(x, res, var.name, collection) {
  if (!isTRUE(res)) {
    if (is.null(collection))
      mstop("Assertion on '%s' failed: %s", vname(x, var.name), res)
    collection$push(sprintf("Variable '%s': %s", vname(x, var.name), res))
  }
  return(invisible(x))
}

#' @rdname makeAssertion
#' @param check.fun [\code{function}]\cr
#'  Function which checks the input. Must return \code{TRUE} on success and a string with the error message otherwise.
#' @param env [\code{environment}]\cr
#'  The environment of the created function. Default is the \code{\link[base]{parent.frame}}.
#' @export
makeAssertionFunction = function(check.fun, env = parent.frame()) {
  fn.name = if (!is.character(check.fun)) deparse(substitute(check.fun)) else check.fun
  check.fun = match.fun(check.fun)

  new.fun = function() TRUE
  formals(new.fun) = c(formals(check.fun), alist(add = NULL, .var.name =))
  tmpl = "{ res = %s(%s); makeAssertion(x, res, .var.name, add) }"
  body(new.fun) = parse(text = sprintf(tmpl, fn.name, paste0(names(formals(check.fun)), collapse = ", ")))
  environment(new.fun) = env
  return(new.fun)
}
