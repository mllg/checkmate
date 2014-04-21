#' Check file system access rights
#'
#' @template checker
#' @param access [\code{character}]\cr
#'  Single string with characters \sQuote{r}, \sQuote{w} and \sQuote{x} to
#'  force a check for read, write or execute access rights.
#' @family checker
#' @export
#' @examples
#'  assert(R.home(), "access", "r")
check_access = function(x, access) {
  qassert(access, "S1")
  if (nzchar(access)) {
    access = match(strsplit(access, "")[[1L]], c("r", "w", "x"))
    if (anyMissing(access) || anyDuplicated(access) > 0L)
      stop("Access pattern invalid, allowed are 'r', 'w' and 'x'")

    if (1L %in% access) {
      w = which.first(file.access(x, 4L) != 0L)
      if (length(w) > 0L)
        return(sprintf("File in '%%s' not readable: '%s'", x[w]))
    }
    if (2L %in% access) {
      w = which.first(file.access(x, 2L) != 0L)
      if (length(w) > 0L)
        return(sprintf("File in '%%s' not writeable: '%s'", x[w]))
    }
    if (3L %in% access) {
      w = which.first(file.access(x, 1L) != 0L)
      if (length(w) > 0L)
        return(sprintf("File in '%%s' not executeable: '%s'", x[w]))
    }
  }
  return(TRUE)
}
