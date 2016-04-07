#' @title Lookup a variable name
#' @description
#' Tries to heuristically determine the variable name of \code{x} in the parent frame
#' with a combination of \code{\link[base]{deparse}} and \code{\link[base]{substitute}}.
#' Used for checkmate's error messages.
#' @param x [ANY]\cr
#'   Object.
#' @return [\code{character(1)}] Variable name.
#' @export
vname = function(x) {
  paste0(deparse(substitute(x, parent.frame(1L)), width.cutoff = 500), collapse = "\n")
}
