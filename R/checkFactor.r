#' Check if an argument is a factor
#'
#' @templateVar fn Factor
#' @template x
#' @inheritParams checkVector
#' @param levels [\code{character}]\cr
#'  Vector of allowed factor levels.
#' @param ordered [\code{logical(1)}]\cr
#'  Check for an ordered factor? If \code{FALSE} or \code{TRUE}, checks explicitly
#'  for an unordered or ordered factor, respectively.
#'  Default is \code{NA} which does not perform a check.
#' @param empty.levels.ok [\code{logical(1)}]\cr
#'  Are empty levels allowed?
#'  Default is \code{TRUE}.
#' @param n.levels [\code{integer(1)}]\cr
#'  Exact number of factor levels.
#'  Default is \code{NULL} (no check).
#' @param min.levels [\code{integer(1)}]\cr
#'  Minimum number of factor levels.
#'  Default is \code{NULL} (no check).
#' @param max.levels [\code{integer(1)}]\cr
#'  Maximum number of factor levels.
#'  Default is \code{NULL} (no check).
#' @template checker
#' @family basetypes
#' @useDynLib checkmate c_check_factor
#' @export
#' @examples
#' x = factor("a", levels = c("a", "b"))
#' testFactor(x)
#' testFactor(x, empty.levels.ok = FALSE)
checkFactor = function(x, levels = NULL, ordered = NA, empty.levels.ok = TRUE, any.missing = TRUE, all.missing = TRUE, len = NULL, min.len = NULL, max.len = NULL, n.levels = NULL, min.levels = NULL, max.levels = NULL, unique = FALSE, names = NULL) {
  .Call("c_check_factor", x, any.missing, all.missing, len, min.len, max.len, unique, names, PACKAGE = "checkmate") %and%
  checkFactorProps(x, levels, ordered, empty.levels.ok, n.levels, min.levels, max.levels)
}

#' @rdname checkFactor
#' @useDynLib checkmate c_check_factor
#' @export
assertFactor = function(x, levels = NULL, ordered = NA, empty.levels.ok = TRUE, any.missing = TRUE, all.missing = TRUE, len = NULL, min.len = NULL, max.len = NULL, n.levels = NULL, min.levels = NULL, max.levels = NULL, unique = FALSE, names = NULL, .var.name) {
  res = .Call("c_check_factor", x, any.missing, all.missing, len, min.len, max.len, unique, names, PACKAGE = "checkmate")
  makeAssertion(res, vname(x, .var.name))
  res = checkFactorProps(x, levels, ordered, empty.levels.ok, n.levels, min.levels, max.levels)
  makeAssertion(res, vname(x, .var.name))
}

#' @rdname checkFactor
#' @useDynLib checkmate c_check_factor
#' @export
testFactor = function(x, levels = NULL, ordered = NA, empty.levels.ok = TRUE, any.missing = TRUE, all.missing = TRUE, len = NULL, min.len = NULL, max.len = NULL, n.levels = NULL, min.levels = NULL, max.levels = NULL, unique = FALSE, names = NULL) {
  res = .Call("c_check_factor", x, any.missing, all.missing, len, min.len, max.len, unique, names, PACKAGE = "checkmate")
  isTRUE(res) && isTRUE(checkFactorProps(x, levels, ordered, empty.levels.ok, n.levels, min.levels, max.levels))
}

checkFactorProps = function(x , levels = NULL, ordered = NA, empty.levels.ok = TRUE, n.levels = NULL, min.levels = NULL, max.levels = NULL) {
  if (!is.null(levels)) {
    qassert(levels, "S")
    if (!setequal(levels(x), levels))
      return(sprintf("Must have levels: %s", collapse(levels)))
  }
  qassert(ordered, "b1")
  if (!is.na(ordered)) {
    x.ordered = is.ordered(x)
    if (ordered && !x.ordered)
      return("Must be an ordered factor")
    else if (!ordered && x.ordered)
      return("Must be an unordered factor")
  }
  qassert(empty.levels.ok, "B1")
  if (!empty.levels.ok) {
    empty = setdiff(levels(x), levels(droplevels(x)))
    if (length(empty) > 0L)
      return(sprintf("Has has empty levels '%s'", collapse(empty, "','")))
  }
  if (!is.null(n.levels)) {
    qassert(n.levels, "X1")
    if (length(levels(x)) != n.levels)
      return(sprintf("Must have exactly %i levels", n.levels))
  }
  if (!is.null(min.levels)) {
    qassert(min.levels, "X1")
    if (length(levels(x)) < min.levels)
      return(sprintf("Must have at least %i levels", min.levels))
  }
  if (!is.null(max.levels)) {
    qassert(max.levels, "X1")
    if (length(levels(x)) > max.levels)
      return(sprintf("Must have at most %i levels", max.levels))
  }
  return(TRUE)
}
