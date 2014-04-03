testInherits = function(x, classes) {
  qassert(classes, "S")
  w = which.first(inherits(x, classes, TRUE) == 0L)
  if (length(w) > 0L)
    return(sprintf("'%%s' must be of class '%s'", classes[w]))
  return(TRUE)
}

#' Checks argument inheritance
#'
#' @param x [\code{ANY}]\cr
#'  Object to check.
#' @param classes [\code{character}]\cr
#'  Class names to check for inheritance.
#' @return [\code{logical(1)}] Returns \code{TRUE} if \code{x}
#'  inherits from all \code{classes}.
#'  Throws an exception on failure for assertion.
#' @export
checkInherits = function(x, classes) {
  isTRUE(testInherits(x, classes))
}

#' @rdname checkInherits
#' @export
assertInherits = function(x, classes) {
  amsg(testInherits(x, classes), dps(x))
}
