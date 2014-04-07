#' Checks if an argument is a character
#'
#' @templateVar id Character
#' @template testfuns
#' @param pattern [\code{character(1L)}]\cr
#'  Regular expression as used to use in \code{\link[base]{grepl}}.
#'  All elements of \code{x} must comply to this pattern.
#' @param ignore.case [\code{logical(1)}]\cr
#'  See \code{\link[base]{grepl}}. Default is \code{FALSE}.
#' @param perl [\code{logical(1)}]\cr
#'  See \code{\link[base]{grepl}}. Default is \code{FALSE}.
#' @param fixed [\code{logical(1)}]\cr
#'  See \code{\link[base]{grepl}}. Default is \code{FALSE}.
#' @param ... [ANY]\cr
#'  Additional parameters used in a call of \code{\link{isVector}}
#'  or \code{\link{assertVector}}.
#' @family basetypes
#' @export
assertCharacter = function(x, pattern, ignore.case = FALSE, perl = FALSE, fixed = FALSE, ..., .var.name) {
  amsg(testVectorProps(x, ...), vname(x, .var.name))
  amsg(testCharacter(x, pattern, ignore.case, perl, fixed), vname(x, .var.name))
}

#' @rdname assertCharacter
#' @export
isCharacter = function(x, pattern, ignore.case = FALSE, perl = FALSE, fixed = FALSE, ...) {
  isTRUE(testVectorProps(x, ...)) && isTRUE(testCharacter(x, pattern, ignore.case, perl, fixed))
}

#' @rdname assertCharacter
#' @export
asCharacter = function(x, pattern, ignore.case = FALSE, perl = FALSE, fixed = FALSE, ..., .var.name) {
  assertCharacter(x, pattern, ignore.case, perl, fixed, ..., .var.name = vname(x, .var.name))
  x
}

testCharacter = function(x, pattern, ignore.case = FALSE, perl = FALSE, fixed = FALSE) {
  if (!is.character(x))
    return("'%s' must be a character")

  if (!missing(pattern)) {
    qassert(pattern, "S1")
    ok = grepl(pattern, x, ignore.case=ignore.case, perl=perl, fixed=fixed)
    if(!all(ok))
      return(sprintf("%s'%%s' must comply to pattern '%s",
          if(length(x) > 1L) "All elements of " else "",
          pattern))
  }
  return(TRUE)
}
