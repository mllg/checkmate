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
