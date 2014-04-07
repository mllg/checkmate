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

#' @rdname assertFile
#' @export
asDirectory = function(fn, access = "", .var.name) {
  assertDirectory(fn, access = access, .var.name = vname(x, .var.name))
  fn
}

testDirectory = function(fn, access = "") {
  qassert(fn, "S")
  if (length(fn) == 0L)
    return("No diretory provided in '%%s'")

  isdir = file.info(fn)$isdir
  w = which.first(is.na(isdir))
  if (length(w) > 0L)
    return(sprintf("Directory in '%%s' does not exist: '%s'", fn[w]))
  w = which.first(!isdir)
  if (length(w) > 0L)
    return(sprintf("Directory in '%%s' expected, file in place: '%s'", fn[w]))

  return(testAccess(fn, access))
}
