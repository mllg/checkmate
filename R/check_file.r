#' Check existance and access rights of files
#'
#' @template checker
#' @param access [\code{character}]\cr
#'  Single string with characters \sQuote{r}, \sQuote{w} and \sQuote{x} to
#'  force a check for read, write or execute access rights.
#' @family checker
#' @export
check_file = function(x, access = "") {
  qassert(x, "S")
  if (length(x) == 0L)
    return("No files provided in '%s'")

  isdir = file.info(x)$isdir
  w = which.first(is.na(isdir))
  if (length(w) > 0L)
    return(sprintf("File in '%%s' does not exist: '%s'", x[w]))
  w = which.first(isdir)
  if (length(w) > 0L)
    return(sprintf("'%%s' expected to contain files, directory in place: '%s'", x[w]))

  return(check_access(x, access))
}
