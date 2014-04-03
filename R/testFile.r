testAccess = function(fn, access) {
  qassert(access, "S1")
  if (nzchar(access)) {
    access = strsplit(access, "")[[1L]]

    if ("r" %in% access) {
      w = which.first(file.access(fn, 4L) != 0L)
      if (length(w) > 0L)
        return(sprintf("File in '%%s' not readable: '%s'", fn[w]))
    }
    if ("w" %in% access) {
      w = which.first(file.access(fn, 2L) != 0L)
      if (length(w) > 0L)
        return(sprintf("File in '%%s' not writeable: '%s'", fn[w]))
    }
    if ("x" %in% access) {
      w = which.first(file.access(fn, 1L) != 0L)
      if (length(w) > 0L)
        return(sprintf("File in '%%s' not executeable: '%s'", fn[w]))
    }
  }
  return(TRUE)
}

testFile = function(fn, access = "") {
  qassert(fn, "S")

  isdir = file.info(fn)$isdir
  w = which.first(is.na(isdir))
  if (length(w) > 0L)
    return(sprintf("File in '%%s' does not exist: '%s'", fn[w]))
  w = which.first(isdir)
  if (length(w) > 0L)
    return(sprintf("File in '%%s' expected, directory in place: '%s'", fn[w]))

  return(testAccess(fn, access))
}

testDirectory = function(fn, access = "") {
  qassert(fn, "S")

  isdir = file.info(fn)$isdir
  w = which.first(is.na(isdir))
  if (length(w) > 0L)
    return(sprintf("Directory in '%%s' does not exist: '%s'", fn[w]))
  w = which.first(!isdir)
  if (length(w) > 0L)
    return(sprintf("Directory in '%%s' expected, file in place: '%s'", fn[w]))

  return(testAccess(fn, access))
}


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
checkFile = function(fn, access = "") {
  isTRUE(testFile(fn, access))
}


#' @rdname assertFile
#' @export
checkDirectory = function(fn, access = "") {
  isTRUE(testDirectory(fn, access))
}

#' @rdname assertFile
#' @export
assertDirectory = function(fn, access = "", .var.name) {
  amsg(testDirectory(fn, access), vname(fn, .var.name))
}
