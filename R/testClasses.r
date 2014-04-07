#' Checks argument inheritance
#'
#' @param x [\code{ANY}]\cr
#'  Object to check.
#' @param classes [\code{character}]\cr
#'  Class names to check for inheritance.
#' @param .var.name [\code{logical(1)}]\cr
#'  Argument name to print in error message. If missing,
#'  the name of \code{x} will be retrieved via \code{\link[base]{substitute}}.
#' @return [\code{logical(1)}] Returns \code{TRUE} if \code{x}
#'  inherits from all \code{classes}.
#'  Throws an exception on failure for assertion.
#' @export
assertClasses = function(x, classes, .var.name) {
  amsg(testClasses(x, classes), vname(x, .var.name))
}

#' @rdname assertClasses
#' @export
isClasses = function(x, classes) {
  # FIXME: isClass is in methods, this name is fugly
  isTRUE(testClasses(x, classes))
}

testClasses = function(x, classes) {
  qassert(classes, "S")
  w = which.first(inherits(x, classes, TRUE) == 0L)
  if (length(w) > 0L)
    return(sprintf("'%%s' must be of class '%s'", classes[w]))
  return(TRUE)
}
