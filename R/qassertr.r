#' @export
#' @rdname qcheckr
#' @useDynLib checkmate c_qassert
qassertr = function(x, rules) {
  res = .Call("c_qassert", x, rules, TRUE, PACKAGE = "checkmate")
  if (!isTRUE(res)) {
    varname = deparse(substitute(x))
    if (length(res) > 1L) {
      stop("error checking argument '", varname, "'.\n",
        "One of the following must apply:\n",
        paste(strwrap(res, prefix = " * "), collapse = "\n"))
    }
    stop("Error checking '", varname, "': ", res)
      assert_to_error(res, deparse(substitute(x)))
  }
  invisible(TRUE)
}
