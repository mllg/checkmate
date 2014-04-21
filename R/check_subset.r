#' Check if object is a subset of a set
#'
#' @template checker
#' @param choices [\code{atomic}]\cr
#'  Set of possible values.
#' @family checker
#' @export
#' @examples
#'  assert(c("a", "z"), "subset", letters)
check_subset = function(x, choices) {
  qassert(choices, "a+")
  not.ok = which.first(x %nin% choices)
  if (length(not.ok) > 0L)
    return(sprintf("'%%s' has element '%s', but all elements should be element of set {'%s'}", x[not.ok], collapse(choices, "','")))
  return(TRUE)
}
