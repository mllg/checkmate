#' Check existance and access rights of files
#'
#' @template checker
#' @inheritParams check_access
#' @family filesystem
#' @export
#' @examples
#'  # Check if R's COPYING file is readable
#'  test(file.path(R.home(), "COPYING"), "file", access = "r")
#'
#'  # Check if R's COPYING file is writeable
#'  test(file.path(R.home(), "COPYING"), "file", access = "w")
check_file = function(x, access = "") {
  qassert(x, "S")
  if (length(x) == 0L)
    return("No files provided in '%s'")

  isdir = file.info(x)$isdir
  not.ok = which.first(is.na(isdir))
  if (length(not.ok) > 0L)
    return(sprintf("File in '%%s' does not exist: '%s'", x[not.ok]))
  not.ok = which.first(isdir)
  if (length(not.ok) > 0L)
    return(sprintf("'%%s' expected to contain files, directory in place: '%s'", x[not.ok]))

  return(check_access(x, access))
}
