testAccess = function(fn, access) {
  qassert(access, "S1")
  if (nzchar(access)) {
    access = strsplit(access, "")[[1L]]

    if ("r" %in% access) {
      w = which(file.access(fn, 4L) != 0L)
      if (length(w) > 0L)
        return(sprintf("File not readable: '%s'", fn[w[1L]]))
    }
    if ("w" %in% access) {
      w = which(file.access(fn, 2L) != 0L)
      if (length(w) > 0L)
        return(sprintf("File not writeable: '%s'", fn[w[1L]]))
    }
    if ("x" %in% access) {
      w = which(file.access(fn, 1L) != 0L)
      if (length(w) > 0L)
        return(sprintf("File not executeable: '%s'", fn[w[1L]]))
    }
  }
  return(TRUE)
}

testFile = function(fn, access="") {
  qassert(fn, "S")

  w = which(!file.exists(fn))
  if (length(w) > 0L)
    return(sprintf("File does not exist: '%s'", fn[w[1L]]))
  w = which(file.info(fn)$isdir)
  if (length(w) > 0L)
    return(sprintf("File expected, directory in place: '%s'", fn[w[1L]]))

  return(testAccess(fn, access))
}

testDirectory = function(fn, access="") {
  qassert(fn, "S")

  w = which(!file.exists(fn))
  if (length(w) > 0L)
    return(sprintf("Directory does not exist: '%s'", fn[w[1L]]))
  w = which(!file.info(fn)$isdir)
  if (length(w) > 0L)
    return(sprintf("Directory expected, file in place: '%s'", fn[w[1L]]))

  return(testAccess(fn, access))
}


#' Check or assert  existance and access rights of files and directories
#'
#' @param fn [\code{character}\code{function}]\cr
#'  Vector of file or directory names names
#' @param access [\code{character}]\cr
#'  Single string with characters \sQuote{r}, \sQuote{w} and \sQuote{x} to
#'  force a check for read, write or execute access rights.
#' @return [\code{logical(1)}] Returns \code{TRUE} on success and
#'  throws an exception on failure for assertion.
#' @export
checkFile = function(fn, access="") {
  isTRUE(testFile(fn, access))
}

#' @rdname checkFile
#' @export
assertFile = function(fn, access="") {
  amsg(testFile(fn, access))
}


#' @rdname checkFile
#' @export
checkDirectory = function(fn, access="") {
  isTRUE(testDirectory(fn, access))
}

#' @rdname checkFile
#' @export
assertDirectory = function(fn, access="") {
  amsg(testDirectory(fn, access))
}
