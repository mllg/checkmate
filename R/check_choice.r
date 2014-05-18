#' Check if an object is an element of a given set
#'
#' @template checker
#' @param choices [\code{atomic}]\cr
#'  Set of possible values.
#' @family set
#' @export
#' @examples
#'  test("x", "choice", letters)
check_choice = function(x, choices) {
  qassert(x, "a1")
  qassert(choices, "a+")
  if (x %nin% choices)
    return(sprintf("'%%s' must be element of {'%s'}", collapse(choices, "','")))
  return(TRUE)
}
