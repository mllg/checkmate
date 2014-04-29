#' Check if an object is element of a given set
#'
#' @template checker
#' @param choices [\code{atomic}]\cr
#'  Set of possible values.
#' @family set
#' @export
#' @examples
#'  test("x", "elementOf", letters)
check_elementOf = function(x, choices) {
  qassert(x, "a1")
  qassert(choices, "a+")
  if (x %nin% choices)
    return(sprintf("'%%s' must be element of {'%s'}", collapse(choices, "','")))
  return(TRUE)
}
