#' Check existence and access rights of files
#'
#' @templateVar fn File
#' @template x
#' @inheritParams checkAccess
#' @template checker
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

  d.e = dir.exists(x)
  w = wf(!file.exists(x) || d.e)
  if (length(w) > 0L) {
    if (d.e[w])
      return(sprintf("File expected, but directory in place: '%s'", x[w]))
    return(sprintf("File does not exist: '%s'", x[w]))
  }

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
  res = checkFile(x, access)
  isTRUE(res)
}

#' @rdname checkFile
#' @template expect
#' @export
expect_file = function(x, access = "", info = NULL, label = NULL) {
  res = checkFile(x, access)
  makeExpectation(res, info = info, label = vname(x, label))
}
