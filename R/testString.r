testString = function(x, pattern, ignore.case=FALSE, perl=FALSE, fixed=FALSE) {
  if (!is.character(x))
    return("'%s' must be a string")

  if (!missing(pattern)) {
    qassert(pattern, "S1")
    ok = grepl(pattern, x, ignore.case=ignore.case, perl=perl, fixed=fixed)
    if(!all(ok))
      return(sprintf("%s'%s' must comply to pattern '%s",
          if(length(x) > 1L) "All elements of " else "",
          pattern))
  }
  return(TRUE)
}


#' Checks if an argument is a string
#'
#' @param x [\code{ANY}]\cr
#'  Object to check.
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
#'  Additional parameters used in a call of \code{\link{checkVector}}
#'  or \code{\link{checkVector}}.
#' @return [\code{logical(1)}] Returns \code{TRUE} on success.
#'  Throws an exception on failure for assertion.
#' @export
checkString = function(x, pattern, ignore.case=FALSE, perl=FALSE, fixed=FALSE, ...) {
  isTRUE(testVector(x, ...)) && isTRUE(testString(x, pattern, ignore.case, perl, fixed))
}

assertString = function(x, pattern, ignore.case=FALSE, perl=FALSE, fixed=FALSE, ...) {
  amsg(testVector(x, ...), dps(x))
  amsg(testString(x, pattern, ignore.case, perl, fixed), dps(x))
}
