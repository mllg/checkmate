#' Check or assert existance and access rights of files and directories
#'
#' @param x [\code{character}\code{function}]\cr
#'  Vector of file or directory names.
#' @param access [\code{character}]\cr
#'  Single string with characters \sQuote{r}, \sQuote{w} and \sQuote{x} to
#'  force a check for read, write or execute access rights.
#' @param .var.name [\code{logical(1)}]\cr
#'  Argument name to print in error message. If missing,
#'  the name of \code{x} will be retrieved via \code{\link[base]{substitute}}.
#' @return [\code{logical(1)}] Returns \code{TRUE} on success.
#'  Throws an exception on failure for assertion.
#' @export
assertFile = function(x, access = "", .var.name) {
  amsg(testFile(x, access), vname(x, .var.name))
}

#' @rdname assertFile
#' @export
isFile = function(x, access = "") {
  isTRUE(testFile(x, access))
}

#' @rdname assertFile
#' @export
asFile = function(x, access = "", .var.name) {
  assertFile(x, access = access, .var.name = vname(x, .var.name))
  x
}

testFile = function(x, access = "") {
  qassert(x, "S")
  if (length(x) == 0L)
    return("No files provided in '%s'")

  isdir = file.info(x)$isdir
  w = which.first(is.na(isdir))
  if (length(w) > 0L)
    return(sprintf("File in '%%s' does not exist: '%s'", x[w]))
  w = which.first(isdir)
  if (length(w) > 0L)
    return(sprintf("File in '%%s' expected, directory in place: '%s'", x[w]))

  return(testAccess(x, access))
}

