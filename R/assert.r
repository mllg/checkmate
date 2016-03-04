#' Combine multiple checks into one assertion
#'
#' @description
#' You can call this function with an arbitrary number of of \code{check*}
#' functions, i.e. functions provided by this package or your own functions which
#' return \code{TRUE} on success and the error message as \code{character(1)} otherwise.
#' The resulting assertion is successful, if \code{combine} is
#' \dQuote{or} (default) and at least one check evaluates to \code{TRUE} or
#' \code{combine} is \dQuote{and} and all checks evaluate to \code{TRUE}.
#' Otherwise, \code{assert} throws an informative error message.
#'
#' @param ... [any]\cr
#'  List of calls to check functions.
#' @param combine [\code{character(1)}]\cr
#'  \dQuote{or} or \dQuote{and} to combine the check functions with an OR
#'  or AND, respectively.
#' @template var.name
#' @return Throws an error if all checks fail and invisibly returns
#'  \code{TRUE} otherwise.
#' @export
#' @examples
#' x = 1:10
#' assert(checkNull(x), checkInteger(x, any.missing = FALSE))
#' \dontrun{
#' x = 1
#' assert(checkChoice(x, c("a", "b")), checkDataFrame(x))
#' }
assert = function(..., combine = "or", .var.name = NULL) {
  assertChoice(combine, c("or", "and"))
  dots = match.call(expand.dots = FALSE)$...
  env = parent.frame()
  if (combine == "or") {
    msgs = character(length(dots))
    for (i in seq_along(dots)) {
      val = eval(dots[[i]], envir = env)
      if (identical(val, TRUE))
        return(invisible(TRUE))
      msgs[i] = as.character(val)
    }
    if (is.null(.var.name))
      .var.name = as.character(dots[[1L]])[2L]
    if (length(msgs) > 1L)
      msgs = sprintf("%s: %s", lapply(dots, function(x) as.character(x)[1L]), msgs)
    mstop(qamsg(NULL, msgs, .var.name, FALSE))
  } else {
    for (i in seq_along(dots)) {
      val = eval(dots[[i]], envir = env)
      if (!identical(val, TRUE)) {
        if (is.null(.var.name))
          .var.name = as.character(dots[[1L]])[2L]
        mstop(qamsg(NULL, val, .var.name, recursive = FALSE))
      }
    }
    return(invisible(TRUE))
  }
}
