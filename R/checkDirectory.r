#' Check for existence and access rights of directories
#'
#' @templateVar fn Directory
#' @template x
#' @inheritParams checkAccess
#' @inheritParams checkFile
#' @template checker
#' @family filesystem
#' @export
#' @examples
#' # Is R's home directory readable?
#' testDirectory(R.home(), "r")
#'
#' # Is R's home directory readable and writable?
#' testDirectory(R.home(), "rw")
checkDirectory = function(x, access = "") {
  if (!qtest(x, "S+"))
    return("No directory provided")

  w = wf(!dir.exists(x))
  if (length(w) > 0L) {
    if (file.exists(x[w]))
      return(sprintf("Directory extected, but file in place: '%s'", x[w]))
    return(sprintf("Directory '%s' does not exists", x[w]))
  }

  return(checkAccess(x, access))
}

#' @rdname checkDirectory
#' @export
assertDirectory = function(x, access = "", add = NULL, .var.name) {
  res = checkDirectory(x, access)
  makeAssertion(res, vname(x, .var.name), add)
}

#' @rdname checkDirectory
#' @export
testDirectory = function(x, access = "", .var.name) {
  res = checkDirectory(x, access)
  isTRUE(res)
}

#' @rdname checkDirectory
#' @template expect
#' @export
expect_directory = function(x, access = "", info = NULL, label = NULL) {
  res = checkDirectory(x, access)
  makeExpectation(res, info = info, label = vname(x, label))
}
