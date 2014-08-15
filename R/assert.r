#' Combine multiple checks into one assertion
#'
#' @param ... [ANY]\cr
#'  List of calls to check functions.
#' @param .var.name [character(1)]\cr
#'  Name of object to check. Defaults to a heuristic to determine
#'  the name of the first argument of the first call.
#' @return Throws an error if all checks fails and invisibly returns
#'  \code{TRUE} otherwise.
#' @export
#' @examples
#' x = 1:10
#' assert(checkNull(x), checkInteger(x, any.missing = FALSE))
#' \dontrun{
#' x = 1
#' assert(checkChoice(x, c("a", "b")), checkDataFrame(x))
#' }
assert = function(..., .var.name) {
  dots = match.call(expand.dots = FALSE)$...
  env = parent.frame()
  msgs = character(length(dots))
  for (i in seq_along(dots)) {
    val = eval(dots[[i]], envir = env)
    if (isTRUE(val))
      return(invisible(TRUE))
    msgs[i] = as.character(val)
  }
  if (missing(.var.name))
    .var.name = as.character(dots[[1L]])[2L]
  if (length(msgs) > 1L)
    msgs = sprintf("%s: %s", lapply(dots, function(x) as.character(x)[1L]), msgs)
  mstop(qamsg(NULL, msgs, .var.name, FALSE))
}
