getChecker = function(checker) {
  if (is.function(checker))
    return(checker)
  ee = as.environment("package:checkmate")
  fun = ee[[paste0("check_", checker)]]
  if (!is.function(fun))
    stop(sprintf("Checker function '%s' not found", fn))
  fun
}

#' Evaluate a check function and throw exception on failure
#'
#' @param x [ANY]\cr
#'  Object to check.
#' @param checker [character(1)]\cr
#'  Name of the checker function without preceding \dQuote{check_}, e.g. \dQuote{numeric}.
#' @param ... [ANY]\cr
#'  Additional parameters passed down to \code{checker}.
#' @param .var.name [\code{character(1)}]\cr
#'  Phony name for \code{x} to use in error message.
#'  If not provided, \code{x} will be substituted.
#' @return \code{TRUE} on success, an exception is thrown otherwise.
#' @family evaluate
#' @export
assert = function(x, checker, ..., .var.name) {
  checker = getChecker(checker)
  msg = checker(x, ...)
  if (!isTRUE(msg))
    stop(simpleError(sprintf(msg, vname(x, .var.name)), call = sys.call(1L)))
  invisible(TRUE)
}

#' Evaluate a check function to a logical value
#'
#' @inheritParams assert
#' @return \code{TRUE} on success, \code{FALSE} otherwise.
#' @family evaluate
#' @export
test = function(x, checker, ...) {
  checker = getChecker(checker)
  isTRUE(checker(x, ...))
}


#' Evaluate a check function and return object on success
#'
#' @inheritParams assert
#' @return \code{x} on success, an exception is thrown otherwise.
#' @family evaluate
#' @export
pass = function(x, checker, ..., .var.name) {
  checker = getChecker(checker)
  msg = checker(x, ...)
  if (!isTRUE(msg))
    stop(simpleError(sprintf(msg, vname(x, .var.name)), call = sys.call(1L)))
  x
}
