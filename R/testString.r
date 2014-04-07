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
#'  Additional parameters used in a call of \code{\link{isVector}}
#'  or \code{\link{assertVector}}.
#' @param .var.name [\code{logical(1)}]\cr
#'  Argument name to print in error message. If missing,
#'  the name of \code{x} will be retrieved via \code{\link[base]{substitute}}.
#' @return [\code{logical(1)}] Returns \code{TRUE} on success.
#'  Throws an exception on failure for assertion.
#' @export
assertString = function(x, pattern, ignore.case = FALSE, perl = FALSE, fixed = FALSE, ..., .var.name) {
  amsg(testVectorProps(x, ...), vname(x, .var.name))
  amsg(testString(x, pattern, ignore.case, perl, fixed), vname(x, .var.name))
}

#' @rdname assertString
#' @export
isString = function(x, pattern, ignore.case = FALSE, perl = FALSE, fixed = FALSE, ...) {
  isTRUE(testVectorProps(x, ...)) && isTRUE(testString(x, pattern, ignore.case, perl, fixed))
}

#' @rdname assertString
#' @export
asString = function(x, pattern, ignore.case = FALSE, perl = FALSE, fixed = FALSE, ..., .var.name) {
  assertString(x, pattern, ignore.case, perl, fixed, ..., .var.name = vname(x, .var.name))
  x
}

testString = function(x, pattern, ignore.case = FALSE, perl = FALSE, fixed = FALSE) {
  if (!is.character(x))
    return("'%s' must be a string")

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
