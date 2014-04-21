#' Check vector properties
#'
#' @template checker
#' @param na.ok [\code{logical(1)}]\cr
#'  Are missing values allowed? Default is \code{TRUE}.
#' @param len [\code{integer(1)}]\cr
#'  Exact expected length of \code{x}.
#' @param min.len [\code{integer(1)}]\cr
#'  Minimal length of \code{x}.
#' @param max.len [\code{integer(1)}]\cr
#'  Maximal length of \code{x}.
#' @param names [\code{character(1)}]\cr
#'  Check for names attribute.
#'  See also \code{\link{check_named}} for possible values.
#'  Default is \dQuote{none} which performs no check at all.
#' @family checker
#' @export
#' @examples
#'  test(letters, "vector", min.len = 1L, na.ok = FALSE)
check_vector = function(x, na.ok = TRUE, len, min.len, max.len, names = "any") {
  if (!is.vector(x))
    return("'%%s' must be a vector")
  return(check_vector_props(x, na.ok, len, min.len, max.len))
}

check_vector_props = function(x, na.ok = TRUE, len, min.len, max.len, names = "any") {
  if (!missing(len) && qassert(len, "X1[0,)") && length(x) != len)
    return(sprintf("'%%s' must have length %i", len))
  if (!missing(min.len) && qassert(min.len, "X1[0,)") && length(x) < min.len)
    return(sprintf("'%%s' must have length >= %i", min.len))
  if (!missing(max.len) && qassert(max.len, "X1[0,)") && length(x) > max.len)
    return(sprintf("'%%s' must have length <= %i", max.len))
  if (qassert(na.ok, "B1") && !na.ok && anyMissing(x))
    return("'%s' contains missing values")
  if (qassert(names, "S1") && names != "any") {
    tmp = check_named(x, type = names)
    if (!isTRUE(tmp))
      return(tmp)
  }

  return(TRUE)
}
