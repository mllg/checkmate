#' Check if an object is an element of a given set
#'
#' @templateVar fn Choice
#' @template checker
#' @param choices [\code{atomic}]\cr
#'  Set of possible values.
#' @family set
#' @export
#' @examples
#'  test("x", "choice", letters)
checkChoice = function(x, choices) {
  qassert(x, "a1")
  qassert(choices, "a+")
  if (x %nin% choices)
    return(sprintf("'%%s' must be element of {'%s'}", collapse(choices, "','")))
  return(TRUE)
}

#' @rdname checkChoice
#' @export
assertChoice = function(x, choices, .var.name) {
  makeAssertion(checkChoice(x, choices), vname(x, .var.name))
}

#' @rdname checkChoice
#' @export
testChoice = function(x, choices) {
  makeTest(checkChoice(x, choices))
}
