#' Check for existence and access rights of directories
#'
#' @template checker
#' @inheritParams check_access
#' @inheritParams check_file
#' @family filesystem
#' @export
#' @examples
#'  # Is R's home directory readable?
#'  test(R.home(), "access", "r")
#'
#'  # Is R's home directory writable?
#'  test(R.home(), "access", "w")
check_directory = function(x, access = "") {
  qassert(x, "S")
  if (length(x) == 0L)
    return("'%%s' has length 0, no directories were provided")

  isdir = file.info(x)$isdir
  w = which.first(is.na(isdir))
  if (length(w) > 0L)
    return(sprintf("Directory in '%%s' does not exist: '%s'", x[w]))
  w = which.first(!isdir)
  if (length(w) > 0L)
    return(sprintf("'%%s' expected to contain directories, file in place: '%s'", x[w]))

  return(check_access(x, access))
}
