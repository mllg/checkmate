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

  isdir = file.info(x)$isdir
  w = wf(is.na(isdir))
  if (length(w) > 0L)
    return(sprintf("Directory '%s' does not exists", x[w]))
  w = wf(!isdir)
  if (length(w) > 0L)
    return(sprintf("Directory extected, but file in place: '%s'", x[w]))

  return(checkAccess(x, access))
}

#' @rdname checkDirectory
#' @export
assertDirectory = function(x, access = "", .var.name) {
  res = checkDirectory(x, access)
  makeAssertion(res, vname(x, .var.name))
}

#' @rdname checkDirectory
#' @export
testDirectory = function(x, access = "", .var.name) {
  isTRUE(checkDirectory(x, access))
}
