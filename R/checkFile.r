#' Check existence and access rights of files
#'
#' @templateVar fn File
#' @template checker
#' @inheritParams checkAccess
#' @family filesystem
#' @export
#' @examples
#' # Check if R's COPYING file is readable
#' testFile(file.path(R.home(), "COPYING"), access = "r")
#'
#' # Check if R's COPYING file is readable and writable
#' testFile(file.path(R.home(), "COPYING"), access = "rw")
checkFile = function(x, access = "") {
  if (!qtest(x, "S+"))
    return("No file provided")

  isdir = file.info(x)$isdir
  not.ok = wf(is.na(isdir))
  if (length(not.ok) > 0L)
    return(sprintf("File does not exist: '%s'", x[not.ok]))
  not.ok = wf(isdir)
  if (length(not.ok) > 0L)
    return(sprintf("File expected, but directory in place: '%s'", x[not.ok]))

  return(checkAccess(x, access))
}

#' @export
#' @rdname checkFile
assertFile = function(x, access = "", .var.name) {
  makeAssertion(checkFile(x, access), vname(x, .var.name))
}

#' @rdname checkFile
#' @export
testFile = function(x, access = "") {
  isTRUE(checkFile(x, access))
}
