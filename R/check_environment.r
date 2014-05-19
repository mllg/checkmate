#' Check if an argument is an environment
#'
#' @template checker
#' @param contains [\code{character}]\cr
#'  Vector of object names expected in the environment.
#'  Defaults to \code{character(0)}.
#' @family basetypes
#' @export
#' @examples
#'  ee = as.environment(list(a = 1))
#'  test(ee, "environment")
#'  test(ee, "environment", contains = "a")
checkEnvironment = function(x, contains = character(0L)) {
  qassert(contains, "S")
  if (!is.environment(x))
    return(mustBeClass("environment"))
  if (length(contains) > 0L) {
    w = which.first(contains %nin% ls(x, all.names = TRUE))
    if (length(w) > 0L)
      return(sprintf("Environment '%%s' must contain an object named '%s'", contains[w]))
  }
  return(TRUE)
}

#' @rdname checkEnvironment
#' @export
assertEnvironment = function(x, contains = character(0L), .var.name) {
  makeAssertion(checkEnvironment(x, contains), vname(x, .var.name))
}

#' @rdname checkEnvironment
#' @export
testEnvironment = function(x, contains = character(0L)) {
  makeTest(checkEnvironment(x, contains))
}
