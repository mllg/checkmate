#' Check if object is element of a set
#'
#' @template checker
#' @param choices [\code{atomic}]\cr
#'  Set of possible values.
#' @family checker
#' @export
#' @examples
#'  assert("x", "elementOf", letters)
check_elementOf = function(x, choices) {
  qassert(x, "a1")
  qassert(choices, "a+")
  if (x %nin% choices)
    return(sprintf("'%%s' is '%s', but should be element of set {'%s'}", x, collapse(choices, "','")))
  return(TRUE)
}
