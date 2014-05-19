#' Check if an argument is a vector of type character
#'
#' @template na-handling
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
#' @family basetypes
#' @export
#' @examples
#'  test(letters, "character", min.len = 1, any.missing = FALSE)
#'  test(letters, "character", min.chars = 2)
#'  test("example", "character", pattern = "ple")
check_character = function(x, pattern, ignore.case = FALSE, perl = FALSE, fixed = FALSE, min.chars = 0L, ...) {
  if (!is.character(x) && !allMissingAtomic(x))
    return(mustBeClass("character"))
  check_vector_props(x, ...) %and% check_character_props(x, pattern, ignore.case, perl, fixed, min.chars)
}

check_character_props = function(x, pattern, ignore.case = FALSE, perl = FALSE, fixed = FALSE, min.chars = 0L) {
  qassert(min.chars, "N1")
  if (!missing(pattern)) {
    qassert(pattern, "S1")
    ok = grepl(pattern, x, ignore.case = ignore.case, perl = perl, fixed = fixed)
    if(!all(ok))
      return(sprintf("%s'%%s' must comply to pattern '%s", if(length(x) > 1L) "All elements of " else "", pattern))
  }
  if (min.chars > 0L) {
    if (any(nchar(x) < min.chars))
      return(sprintf("All elements of '%%s' must have at least %i characters", min.chars))
  }
  return(TRUE)
}
