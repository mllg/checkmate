#' Check if an argument is an environment
#'
#' @templateVar fn Environment
#' @template x
#' @param contains [\code{character}]\cr
#'  Vector of object names expected in the environment.
#'  Defaults to \code{character(0)}.
#' @template checker
#' @family basetypes
#' @export
#' @examples
#' ee = as.environment(list(a = 1))
#' testEnvironment(ee)
#' testEnvironment(ee, contains = "a")
checkEnvironment = function(x, contains = character(0L)) {
  qassert(contains, "S")
  if (!is.environment(x))
    return("Must be an environment")
  if (length(contains) > 0L) {
    w = wf(contains %nin% ls(x, all.names = TRUE))
    if (length(w) > 0L)
      return(sprintf("Must contain an object with name '%s'", contains[w]))
  }
  return(TRUE)
}

#' @rdname checkEnvironment
#' @export
assertEnvironment = function(x, contains = character(0L), .var.name) {
  res = checkEnvironment(x, contains)
  makeAssertion(res, vname(x, .var.name))
}

#' @rdname checkEnvironment
#' @export
testEnvironment = function(x, contains = character(0L)) {
  isTRUE(checkEnvironment(x, contains))
}
