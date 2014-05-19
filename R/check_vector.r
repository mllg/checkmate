#' Check vector properties
#'
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
#'  Check for names. See \code{\link{check_named}} for possible values.
#'  Default is \dQuote{any} which performs no check at all.
#' @family basetypes
#' @export
#' @examples
#'  test(letters, "vector", min.len = 1L, any.missing = FALSE)
check_vector = function(x, any.missing = TRUE, all.missing = TRUE, len, min.len, max.len, unique = FALSE, names = "any") {
  if (!is.vector(x))
    return(mustBeClass("vector"))
  return(check_vector_props(x, any.missing, all.missing, len, min.len, max.len, unique, names))
}

check_vector_props = function(x, any.missing = TRUE, all.missing = TRUE, len, min.len, max.len, unique = FALSE, names = "any") {
  if (!missing(len) && qassert(len, "X1[0,)") && length(x) != len)
    return(mustLength(len))
  if (!missing(min.len) && qassert(min.len, "X1[0,)") && length(x) < min.len)
    return(sprintf("'%%s' must have length >= %i", min.len))
  if (!missing(max.len) && qassert(max.len, "X1[0,)") && length(x) > max.len)
    return(sprintf("'%%s' must have length <= %i", max.len))
  if (qassert(any.missing, "B1") && !any.missing && anyMissing(x))
    return("'%s' contains missing values")
  if (qassert(all.missing, "B1") && !all.missing && allMissing(x))
    return("'%s' contains only missing values")
  if (qassert(unique, "B1") && unique && anyDuplicated(x) > 0L)
    return("All elements of '%s' must be unique")
  if (qassert(names, "S1") && names != "any") {
    return(check_named(x, type = names))
  }
  return(TRUE)
}
