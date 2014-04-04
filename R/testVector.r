#' Check vector properties
#'
#' @param x [\code{ANY}]\cr
#'  Vector to check.
#' @param na.ok [\code{logical(1)}]\cr
#'  Are missing values allowed? Default is \code{TRUE}.
#' @param len [\code{integer(1)}]\cr
#'  Exact expected length of \code{x}.
#' @param min.len [\code{integer(1)}]\cr
#'  Minimal length of \code{x}.
#' @param max.len [\code{integer(1)}]\cr
#'  Maximal length of \code{x}.
#' @param named [\code{character(1)}]\cr
#'  Check for names attribute.
#'  See also \code{\link{checkNamed}} for possible values.
#'  Default is \dQuote{none} which performs no check at all.
#' @param .var.name [\code{logical(1)}]\cr
#'  Argument name to print in error message. If missing,
#'  the name of \code{x} will be retrieved via \code{\link[base]{substitute}}.
#' @return [\code{logical(1)}] Returns \code{TRUE} on success.
#'  Throws an exception on failure for assertion.
#' @export
assertVector = function(x, na.ok = TRUE, len, min.len, max.len, named = NA, .var.name) {
  amsg(testVector(x, na.ok, len, min.len, max.len), vname(x, .var.name))
}

#' @rdname assertVector
#' @export
checkVector = function(x, na.ok = TRUE, len, min.len, max.len, named = NA) {
  isTRUE(testVector(x, na.ok, len, min.len, max.len))
}

testVector = function(x, na.ok = TRUE, len, min.len, max.len, named = NA) {
  if (!is.vector(x))
    return("'%%s' must be a vector")
  return(testVectorProps(x, na.ok, len, min.len, max.len))
}

testVectorProps = function(x, na.ok = TRUE, len, min.len, max.len, named = NA) {
  if (!missing(len) && assertCount(len) && length(x) != len)
    return(sprintf("'%%s' must have length %i", len))
  if (!missing(min.len) && assertCount(min.len) && length(x) < min.len)
    return(sprintf("'%%s' must have length >= %i", min.len))
  if (!missing(max.len) && assertCount(max.len) && length(x) > max.len)
    return(sprintf("'%%s' must have length <= %i", max.len))
  if (assertFlag(na.ok) && !na.ok && anyMissing(x))
    return("'%s' contains missing values")

  qassert(named, c("b1", "S1"))
  if (!is.na(named)) {
    tmp = testNamed(x, dups.ok = (named != "unique"), strict = (named == "strict"))
  }
  return(TRUE)
}
