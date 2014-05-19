#' Check vector properties
#'
#' @templateVar fn Vector
#' @template checker
#' @param any.missing [\code{logical(1)}]\cr
#'  Are vectors with missing values allowed? Default is \code{TRUE}.
#' @param all.missing [\code{logical(1)}]\cr
#'  Are vectors with only missing values allowed? Default is \code{TRUE}.
#' @param len [\code{integer(1)}]\cr
#'  Exact expected length of \code{x}.
#' @param min.len [\code{integer(1)}]\cr
#'  Minimal length of \code{x}.
#' @param max.len [\code{integer(1)}]\cr
#'  Maximal length of \code{x}.
#' @param unique [\code{logical(1)}]\cr
#'  Must all values be unique? Default is \code{FALSE}.
#' @param names [\code{character(1)}]\cr
#'  Check for names. See \code{\link{checkNamed}} for possible values.
#'  Default is \dQuote{any} which performs no check at all.
#' @family basetypes
#' @export
#' @examples
#'  test(letters, "vector", min.len = 1L, any.missing = FALSE)
checkVector = function(x, any.missing = TRUE, all.missing = TRUE, len = NULL, min.len = NULL, max.len = NULL, unique = FALSE, names = "any") {
  if (!is.vector(x))
    return(mustBeClass("vector"))
  return(checkVectorProps(x, any.missing, all.missing, len, min.len, max.len, unique, names))
}

checkVectorProps = function(x, any.missing = TRUE, all.missing = TRUE, len = NULL, min.len = NULL, max.len = NULL, unique = FALSE, names = "any") {
  if (!is.null(len) && qassert(len, "X1[0,)") && length(x) != len)
    return(mustLength(len))
  if (!is.null(min.len) && qassert(min.len, "X1[0,)") && length(x) < min.len)
    return(sprintf("'%%s' must have length >= %i", min.len))
  if (!is.null(max.len) && qassert(max.len, "X1[0,)") && length(x) > max.len)
    return(sprintf("'%%s' must have length <= %i", max.len))
  if (qassert(any.missing, "B1") && !any.missing && anyMissing(x))
    return("'%s' contains missing values")
  if (qassert(all.missing, "B1") && !all.missing && allMissing(x))
    return("'%s' contains only missing values")
  if (qassert(unique, "B1") && unique && anyDuplicated(x) > 0L)
    return("All elements of '%s' must be unique")
  if (qassert(names, "S1") && names != "any") {
    return(checkNamed(x, type = names))
  }
  return(TRUE)
}

#' @rdname checkVector
#' @export
assertVector = function(x, any.missing = TRUE, all.missing = TRUE, len = NULL, min.len = NULL, max.len = NULL, unique = FALSE, names = "any", .var.name) {
  makeAssertion(checkVector(x, any.missing, all.missing, len, min.len, max.len, unique, names), vname(x, .var.name))
}

#' @rdname checkVector
#' @export
testVector = function(x, any.missing = TRUE, all.missing = TRUE, len = NULL, min.len = NULL, max.len = NULL, unique = FALSE, names = "any") {
  makeTest(checkVector(x, any.missing, all.missing, len, min.len, max.len, unique, names))
}
