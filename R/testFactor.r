#' Checks if an argument is a factor
#'
#' @templateVar id Factor
#' @template testfuns
#' @param levels [\code{character}]\cr
#'  Vector of allowed factor levels.
#' @param empty.levels.ok [\code{logical(1)}]\cr
#'  Are empty levels allowed?
#'  Default is \code{TRUE}.
#' @param ordered [\code{logical(1)}]\cr
#'  Check for an ordered factor? If \code{FALSE}, checks explicitly
#'  for an unordered factor.
#'  Default is \code{NA} which disables this check.
#' @param ... [ANY]\cr
#'  Additional parameters used in a call of \code{\link{isVector}}
#'  or \code{\link{assertVector}}.
#' @family basetypes
#' @export
assertFactor = function(x, levels, ordered = NA, empty.levels.ok = TRUE, ..., .var.name) {
  amsg(testFactor(x, levels, ordered, empty.levels.ok, ...), vname(x, .var.name))
}

#' @rdname assertFactor
#' @export
isFactor = function(x, levels, ordered = NA, empty.levels.ok = TRUE, ...) {
  isTRUE(testFactor(x, levels, ordered, empty.levels.ok, ...))
}

#' @rdname assertFactor
#' @export
asFactor = function(x, levels, ordered = NA, empty.levels.ok = TRUE, ..., .var.name) {
  assertFactor(x, levels, ordered, empty.levels.ok, ..., .var.name = vname(x, .var.name))
  x
}

testFactor = function(x, levels, ordered = NA, empty.levels.ok = TRUE, ...) {
  qassert(ordered, "b1")
  qassert(empty.levels.ok, "B1")
  if (!is.factor(x))
    return("'%s' must be a factor")
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
  testVectorProps(x, ...)
}
