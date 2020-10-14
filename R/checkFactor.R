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
#'  Default is \code{NA} which does not perform any additional check.
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
#' @template null.ok
#' @template checker
#' @family basetypes
#' @useDynLib checkmate c_check_factor
#' @export
#' @examples
#' x = factor("a", levels = c("a", "b"))
#' testFactor(x)
#' testFactor(x, empty.levels.ok = FALSE)
checkFactor = function(x, levels = NULL, ordered = NA, empty.levels.ok = TRUE, any.missing = TRUE, all.missing = TRUE, len = NULL, min.len = NULL, max.len = NULL, n.levels = NULL, min.levels = NULL, max.levels = NULL, unique = FALSE, names = NULL, null.ok = FALSE) {
  .Call(c_check_factor, x, any.missing, all.missing, len, min.len, max.len, unique, names, null.ok) %and%
    checkFactorLevels(x, levels, ordered, empty.levels.ok, n.levels, min.levels, max.levels)
}

checkFactorLevels = function(x , levels = NULL, ordered = NA, empty.levels.ok = TRUE, n.levels = NULL, min.levels = NULL, max.levels = NULL) {
  if (!is.null(x)) {
    if (!is.null(levels)) {
      qassert(levels, "S")
      if (!setequal(levels(x), levels))
        return(sprintf("Must have levels: %s", paste0(levels, collapse = ",")))
    }
    qassert(ordered, "b1")
    if (!is.na(ordered)) {
      x.ordered = is.ordered(x)
      if (ordered && !x.ordered)
        return("Must be an ordered factor, but is unordered")
      else if (!ordered && x.ordered)
        return("Must be an unordered factor, but is ordered")
    }
    qassert(empty.levels.ok, "B1")
    if (!empty.levels.ok) {
      empty = setdiff(levels(x), x)
      if (length(empty) > 0L)
        return(sprintf("Has has empty levels '%s'", paste0(empty, collapse = "','")))
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
  }
  return(TRUE)
}

#' @export
#' @rdname checkFactor
check_factor = checkFactor

#' @export
#' @include makeAssertion.R
#' @template assert
#' @rdname checkFactor
assertFactor = makeAssertionFunction(checkFactor, use.namespace = FALSE)

#' @export
#' @rdname checkFactor
assert_factor = assertFactor

#' @export
#' @include makeTest.R
#' @rdname checkFactor
testFactor = makeTestFunction(checkFactor)

#' @export
#' @rdname checkFactor
test_factor = testFactor

#' @export
#' @include makeExpectation.R
#' @template expect
#' @rdname checkFactor
expect_factor = makeExpectationFunction(checkFactor, use.namespace = FALSE)
