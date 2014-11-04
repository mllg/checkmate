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
#' @template checker
#' @family basetypes
#' @useDynLib checkmate c_check_factor
#' @export
#' @examples
#' x = factor("a", levels = c("a", "b"))
#' testFactor(x)
#' testFactor(x, empty.levels.ok = FALSE)
checkFactor = function(x, levels = NULL, ordered = NA, empty.levels.ok = TRUE, any.missing = TRUE, all.missing = TRUE, len = NULL, min.len = NULL, max.len = NULL, unique = FALSE, names = NULL) {
  .Call("c_check_factor", x, any.missing, all.missing, len, min.len, max.len, unique, names, PACKAGE = "checkmate") %and%
  checkFactorProps(x, levels, ordered, empty.levels.ok)
}

#' @rdname checkFactor
#' @useDynLib checkmate c_check_factor
#' @export
assertFactor = function(x, levels = NULL, ordered = NA, empty.levels.ok = TRUE, any.missing = TRUE, all.missing = TRUE, len = NULL, min.len = NULL, max.len = NULL, unique = FALSE, names = NULL, .var.name) {
  res = .Call("c_check_factor", x, any.missing, all.missing, len, min.len, max.len, unique, names, PACKAGE = "checkmate")
  makeAssertion(res, vname(x, .var.name))
  res = checkFactorProps(x, levels, ordered, empty.levels.ok)
  makeAssertion(res, vname(x, .var.name))
}

#' @rdname checkFactor
#' @useDynLib checkmate c_check_factor
#' @export
testFactor = function(x, levels = NULL, ordered = NA, empty.levels.ok = TRUE, any.missing = TRUE, all.missing = TRUE, len = NULL, min.len = NULL, max.len = NULL, unique = FALSE, names = NULL) {
  isTRUE(.Call("c_check_factor", x, any.missing, all.missing, len, min.len, max.len, unique, names, PACKAGE = "checkmate")) &&
  isTRUE(checkFactorProps(x, levels, ordered, empty.levels.ok))
}

checkFactorProps = function(x , levels = NULL, ordered = NA, empty.levels.ok = TRUE) {
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
  return(TRUE)
}
