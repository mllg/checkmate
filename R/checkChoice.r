#' Check if an object is an element of a given set
#'
#' @templateVar fn Choice
#' @template x
#' @param choices [\code{atomic}]\cr
#'  Set of possible values.
#' @template checker
#' @family set
#' @export
#' @examples
#' testChoice("x", letters)
checkChoice = function(x, choices) {
  qassert(choices, "a")
  if (!qtest(x, "a1") || x %nin% choices)
    return(sprintf("Must be element of set {'%s'}", collapse(unique(choices), "','")))
  return(TRUE)
}
