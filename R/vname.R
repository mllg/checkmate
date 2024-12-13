#' @title Lookup a variable name
#' @description
#' Tries to heuristically determine the variable name of \code{x} in the parent frame
#' with a combination of \code{\link[base]{deparse}} and \code{\link[base]{substitute}}.
#' Used for checkmate's error messages.
#' @param x [\code{any}]\cr
#'   Object.
#' @return [\code{character(1)}] Variable name.
#' @export
vname = function(x) {
  paste0(deparse(eval.parent(substitute(substitute(x))), width.cutoff = 500L), collapse = "\n")
}
