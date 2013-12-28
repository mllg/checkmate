#' @export
#' @rdname qcheck
#' @useDynLib checkmate c_qassert
qassert = function(x, rules) {
  res = .Call("c_qassert", x, rules, FALSE, PACKAGE = "checkmate")
  if (!isTRUE(res)) {
    varname = deparse(substitute(x))
    if (length(res) > 1L) {
      stop("error checking argument '", varname, "'.\n",
        "One of the following must apply:\n",
        paste(strwrap(res, prefix = " * "), collapse = "\n"))
    }
    stop("Error checking '", varname, "': ", res)
  }
  invisible(TRUE)
}
