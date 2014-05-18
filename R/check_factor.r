#' Check if an argument is a factor
#'
#' @template checker
#' @param levels [\code{character}]\cr
#'  Vector of allowed factor levels.
#' @param ordered [\code{logical(1)}]\cr
#'  Check for an ordered factor? If \code{FALSE} or \code{TRUE}, checks explicitly
#'  for an unordered or ordered factor, respectively.
#'  Default is \code{NA} which disables this check.
#' @param empty.levels.ok [\code{logical(1)}]\cr
#'  Are empty levels allowed?
#'  Default is \code{TRUE}.
#' @param ... [ANY]\cr
#'  Additional parameters used in a call of \code{\link{check_vector}}
#'  or \code{\link{check_vector}}.
#' @family basetypes
#' @export
#' @examples
#'  x = factor("a", levels = c("a", "b"))
#'  test(x, "factor")
#'  test(x, "factor", empty.levels.ok = FALSE)
check_factor = function(x, levels, ordered = NA, empty.levels.ok = TRUE, ...) {
  qassert(ordered, "b1")
  qassert(empty.levels.ok, "B1")
  if (!is.factor(x))
    return(mustBeClass("factor"))
  if (!missing(levels)) {
    qassert(levels, "S")
    if (!setequal(levels(x), levels))
      return(sprintf("'%%s' must have levels: %s", collapse(levels)))
  }
  if (!is.na(ordered)) {
    x.ordered = is.ordered(x)
    if (ordered && !x.ordered)
      return("'%s' must be an ordered factor")
    else if (!ordered && x.ordered)
      return("'%s' must be an unordered factor")
  }
  if (!empty.levels.ok) {
    not.ok = which.first(table(x) == 0L)
    if (length(not.ok) > 0L)
      return(sprintf("'%%s' has empty level '%s'", names(not.ok)))
  }
  check_vector_props(x, ...)
}
