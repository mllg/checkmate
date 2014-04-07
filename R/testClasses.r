#' Checks argument inheritance
#'
#' @templateVar id Classes
#' @template testfuns
#' @param classes [\code{character}]\cr
#'  Class names to check for inheritance.
#' @param ordered [\code{logical(1)}]\cr
#'  Expect \code{x} to be specialized in provided order.
#'  Default is \code{FALSE}.
#' @export
assertClasses = function(x, classes, ordered = FALSE, .var.name) {
  amsg(testClasses(x, classes, ordered), vname(x, .var.name))
}

#' @rdname assertClasses
#' @export
isClasses = function(x, classes, ordered = FALSE) {
  # FIXME: isClass is in methods, this name is fugly
  isTRUE(testClasses(x, classes, ordered))
}

testClasses = function(x, classes, ordered = FALSE) {
  qassert(classes, "S")
  qassert(ordered, "B1")
  ord = inherits(x, classes, TRUE)
  w = which.first(ord == 0L)
  if (length(w) > 0L)
    return(sprintf("'%%s' must be of class '%s'", classes[w]))
  if (ordered) {
    w = which.first(ord != seq_along(ord))
    if (length(w) > 0L)
      return(sprintf("'%%s' must have class '%s' in position %i", classes[w], w))
  }
  return(TRUE)
}
