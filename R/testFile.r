#' Check or assert existance and access rights of files and directories
#'
#' @param fn [\code{character}\code{function}]\cr
#'  Vector of file or directory names
#' @param access [\code{character}]\cr
#'  Single string with characters \sQuote{r}, \sQuote{w} and \sQuote{x} to
#'  force a check for read, write or execute access rights.
#' @param .var.name [\code{logical(1)}]\cr
#'  Argument name to print in error message. If missing,
#'  the name of \code{x} will be retrieved via \code{\link[base]{substitute}}.
#' @return [\code{logical(1)}] Returns \code{TRUE} on success.
#'  Throws an exception on failure for assertion.
#' @export
assertFile = function(fn, access = "", .var.name) {
  amsg(testFile(fn, access), vname(fn, .var.name))
}

#' @rdname assertFile
#' @export
isFile = function(fn, access = "") {
  isTRUE(testFile(fn, access))
}

#' @rdname assertFile
#' @export
asFile = function(fn, access = "", .var.name) {
  assertFile(fn, access = access, .var.name = vname(x, .var.name))
  fn
}

testFile = function(fn, access = "") {
  qassert(fn, "S")
  if (length(fn) == 0L)
    return("No files provided in '%s'")

  isdir = file.info(fn)$isdir
  w = which.first(is.na(isdir))
  if (length(w) > 0L)
    return(sprintf("File in '%%s' does not exist: '%s'", fn[w]))
  w = which.first(isdir)
  if (length(w) > 0L)
    return(sprintf("File in '%%s' expected, directory in place: '%s'", fn[w]))

  return(testAccess(fn, access))
}

