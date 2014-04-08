#' Check or assert existance and access rights of files and directories
#'
#' @templateVar id File
#' @template testfuns
#' @param access [\code{character}]\cr
#'  Single string with characters \sQuote{r}, \sQuote{w} and \sQuote{x} to
#'  force a check for read, write or execute access rights.
#' @seealso \code{link{assertDirectory}}
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
  assertFile(x, access, .var.name = vname(x, .var.name))
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
    return(sprintf("'%%s' expected to contain files, directory in place: '%s'", x[w]))

  return(testAccess(x, access))
}
