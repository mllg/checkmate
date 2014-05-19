#' Check if object is a subset of a given set
#'
#' @templateVar fn Subset
#' @template checker
#' @param choices [\code{atomic}]\cr
#'  Set of possible values.
#' @family set
#' @export
#' @examples
#'  test(c("a", "z"), "subset", letters)
checkSubset = function(x, choices) {
  qassert(choices, "a+")
  not.ok = which.first(x %nin% choices)
  if (length(not.ok) > 0L)
    return(sprintf("All elements of '%%s' must be in {'%s'}", collapse(choices, "','")))
  return(TRUE)
}

#' @rdname checkSubset
#' @export
assertSubset = function(x, choices, .var.name) {
  makeAssertion(checkSubset(x, choices), vname(x, .var.name))
}

#' @rdname checkSubset
#' @export
testSubset = function(x, choices) {
  makeTest(checkSubset(x, choices))
}
