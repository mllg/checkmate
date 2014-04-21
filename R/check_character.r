#' Check if an argument is a character vector
#'
#' @template checker
#' @param pattern [\code{character(1L)}]\cr
#'  Regular expression as used to use in \code{\link[base]{grepl}}.
#'  All elements of \code{x} must comply to this pattern.
#' @param ignore.case [\code{logical(1)}]\cr
#'  See \code{\link[base]{grepl}}. Default is \code{FALSE}.
#' @param perl [\code{logical(1)}]\cr
#'  See \code{\link[base]{grepl}}. Default is \code{FALSE}.
#' @param fixed [\code{logical(1)}]\cr
#'  See \code{\link[base]{grepl}}. Default is \code{FALSE}.
#' @param min.chars [\code{integer(1)}]\cr
#'  Minimum number of characters in each element of \code{x}.
#' @param ... [ANY]\cr
#'  Additional parameters used in a call of \code{\link{check_vector}}.
#' @family checker
#' @export
check_character = function(x, pattern, ignore.case = FALSE, perl = FALSE, fixed = FALSE, min.chars = 0L, ...) {
  if (!is.character(x))
    return("'%s' must be a character")
  check_vector_props(x, ...) %and% check_character_props(x, pattern, ignore.case, perl, fixed, min.chars)
}

check_character_props = function(x, pattern, ignore.case = FALSE, perl = FALSE, fixed = FALSE, min.chars = 0L) {
  if (!missing(pattern)) {
    qassert(pattern, "S1")
    ok = grepl(pattern, x, ignore.case = ignore.case, perl = perl, fixed = fixed)
    if(!all(ok))
      return(sprintf("%s'%%s' must comply to pattern '%s",
          if(length(x) > 1L) "All elements of " else "",
          pattern))
  }
  qassert(min.chars, "N1")
  if (min.chars > 0L) {
    w = which.first(nchar(x) < min.chars)
    if (length(w) > 0L)
      return(sprintf("All elements of '%%s' must have at least %i characters", min.chars))
  }
  return(TRUE)
}
