#' Check existence and access rights of files
#'
#' @template checker
#' @inheritParams checkAccess
#' @family filesystem
#' @export
#' @examples
#'  # Check if R's COPYING file is readable
#'  test(file.path(R.home(), "COPYING"), "file", access = "r")
#'
#'  # Check if R's COPYING file is writable
#'  test(file.path(R.home(), "COPYING"), "file", access = "w")
checkFile = function(x, access = "") {
  qassert(x, "S")
  if (length(x) == 0L)
    return("'%%s' has length 0, no files were provided")

  isdir = file.info(x)$isdir
  not.ok = which.first(is.na(isdir))
  if (length(not.ok) > 0L)
    return(sprintf("File in '%%s' does not exist: '%s'", x[not.ok]))
  not.ok = which.first(isdir)
  if (length(not.ok) > 0L)
    return(sprintf("'%%s' expected to contain files, directory in place: '%s'", x[not.ok]))

  return(checkAccess(x, access))
}

#' @rdname checkFile
#' @export
assertFile = function(x, access = "", .var.name) {
  makeAssertion(checkFile(x, access), vname(x, .var.name))
}

#' @rdname checkFile
#' @export
testFile = function(x, access = "") {
  makeTest(checkFile(x, access))
}
