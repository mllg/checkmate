getChecker = function(checker) {
  if (is.function(checker))
    return(checker)
  ee = as.environment("package:checkmate")
  fun = ee[[paste0("check_", checker)]]
  if (!is.function(fun))
    stop(sprintf("Checker function '%s' not found", fn))
  fun
}

#' Evaluate a check function
#'
#' All functions apply the check function \code{checker} on
#' \code{x} but react different on the check result.
#' Function \code{assert} invisibly returns \code{TRUE} on success and raises
#' an R exeception otherwise.
#' Function \code{check} returns the check result as single logical value
#' Function \code{pass} returns \code{x} on success and raises an exception otherwise.
#'
#' @param x [ANY]\cr
#'  Object to check.
#' @param checker [\code{character(1)} or \code{function}]\cr
#'  Either the name of a check function without preceding \dQuote{check_}
#'  (e.g. \dQuote{numeric} for \code{\link{check_numeric}}) or a function.
#'  The function is expected to return \code{TRUE} for a success check and
#'  return a string with placeholder \dQuote{\%s} (see \code{\link[base]{sprintf}}
#'  for \code{.var.name}.
#' @param ... [ANY]\cr
#'  Additional parameters passed down to \code{checker}.
#' @param .var.name [\code{character(1)}]\cr
#'  Phony name for \code{x} to use in error message.
#'  If not provided, \code{x} will be substituted.
#' @return See Description.
#' @family evaluate
#' @export
assert = function(x, checker, ..., .var.name) {
  checker = getChecker(checker)
  msg = checker(x, ...)
  if (!isTRUE(msg))
    stop(simpleError(sprintf(msg, vname(x, .var.name)), call = sys.call(1L)))
  invisible(TRUE)
}

#' @rdname assert
#' @export
test = function(x, checker, ...) {
  checker = getChecker(checker)
  isTRUE(checker(x, ...))
}


#' @rdname assert
#' @export
pass = function(x, checker, ..., .var.name) {
  checker = getChecker(checker)
  msg = checker(x, ...)
  if (!isTRUE(msg))
    stop(simpleError(sprintf(msg, vname(x, .var.name)), call = sys.call(1L)))
  x
}
