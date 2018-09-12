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
#'  Defaults to a heuristic name lookup.
#' @param collection [\code{\link{AssertCollection}}]\cr
#'  If an \code{\link{AssertCollection}} is provided, the error message is stored
#'  in it. If \code{NULL}, an exception is raised if \code{res} is not
#'  \code{TRUE}.
#' @return \code{makeAssertion} invisibly returns the checked object if the check was successful,
#'  and an exception is raised (or its message stored in the collection) otherwise.
#'  \code{makeAssertionFunction} returns a \code{function}.
#' @export
#' @family CustomConstructors
#' @include helper.R
#' @examples
#' # Simple custom check function
#' checkFalse = function(x) if (!identical(x, FALSE)) "Must be FALSE" else TRUE
#'
#' # Create the respective assert function
#' assertFalse = function(x, .var.name = vname(x), add = NULL) {
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
      mstop("Assertion on '%s' failed: %s.", var.name, res, call. = sys.call(-2L))
    assertClass(collection, "AssertCollection", .var.name = "add")
    collection$push(sprintf("Variable '%s': %s.", var.name, res))
  }
  return(invisible(x))
}

#' @rdname makeAssertion
#' @template makeFunction
#' @template use.namespace
#' @param coerce [\code{logical(1)}]\cr
#'  If \code{TRUE}, injects some lines of code to convert numeric values to integer after an successful assertion.
#'  Currently used in \code{\link{assertCount}}, \code{\link{assertInt}} and \code{\link{assertIntegerish}}.
#' @export
makeAssertionFunction = function(check.fun, c.fun = NULL, use.namespace = TRUE, coerce = FALSE, env = parent.frame()) {
  fn.name = if (!is.character(check.fun)) deparse(substitute(check.fun)) else check.fun
  check.fun = match.fun(check.fun)
  cargs = fargs = formals(args(check.fun))
  x = NULL

  if (is.null(c.fun)) {
    c.call = sprintf("%s(%s)", fn.name, paste0(names(cargs), collapse = ", "))
  } else {
    c.call = sprintf(".Call(%s)", paste0(c(c.fun, names(cargs)), collapse = ", "))
  }

  if (coerce) {
    fargs = c(fargs, alist(coerce = FALSE))
    coerce.call = "if (isTRUE(coerce) && isTRUE(res)) storage.mode(x) = \"integer\""
  } else {
    coerce.call = ""
  }

  if (use.namespace) {
    fargs = c(fargs, alist(.var.name = checkmate::vname(x), add = NULL))
    assert.call = "checkmate::makeAssertion"
  } else {
    fargs = c(fargs, alist(.var.name = vname(x), add = NULL))
    assert.call = "makeAssertion"
  }


  tmpl = "{ res = %s;%s; %s(x, res, .var.name, add) }"
  new.fun = function() TRUE
  formals(new.fun) = fargs
  body(new.fun) = parse(text = sprintf(tmpl, c.call, coerce.call, assert.call))
  environment(new.fun) = env
  return(new.fun)
}
