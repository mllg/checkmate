testAccess = function(fn, access) {
  qassert(access, "S1")
  if (nzchar(access)) {
    access = strsplit(access, "")[[1L]]

    if ("r" %in% access) {
      w = which(file.access(fn, 4L) != 0L)
      if (length(w))
        return(paste0("File not readable: ", fn[w[1L]]))
    }
    if ("w" %in% access) {
      w = which(file.access(fn, 2L) != 0L)
      if (length(w))
        return(paste0("File not writeable: ", fn[w[1L]]))
    }
    if ("x" %in% access) {
      w = which(file.access(fn, 1L) != 0L)
      if (length(w))
        return(paste0("File not executeable: ", fn[w[1L]]))
    }
  }
  return("")
}

testFile = function(fn, access="") {
  qassert(fn, "S")

  w = which(!file.exists(fn))
  if (length(w))
    return(paste0("File does not exist: ", fn[w[1L]]))
  w = which(file.info(fn)$isdir)
  if (length(w))
    return(paste0("File expected, directory in place: ", fn[w[1L]]))

  return(testAccess(fn, access))
}

testDirectory = function(fn, access="") {
  qassert(fn, "S")

  w = which(!file.exists(fn))
  if (length(w))
    return(paste0("Directory does not exist: ", fn[w[1L]]))
  w = which(!file.info(fn)$isdir)
  if (length(w))
    return(paste0("Directory expected, file in place: ", fn[w[1L]]))

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
  makeCheckReturn(testFile(fn, access))
}

#' @rdname checkFile
#' @export
assertFile = function(fn, access="") {
  makeAssertReturn(testFile(fn, access))
}


#' @rdname checkFile
#' @export
checkDirectory = function(fn, access="") {
  makeCheckReturn(testDirectory(fn, access))
}

#' @rdname checkFile
#' @export
assertDirectory = function(fn, access="") {
  makeAssertReturn(testDirectory(fn, access))
}
