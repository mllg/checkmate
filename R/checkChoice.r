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

#' @rdname checkChoice
#' @export
assertChoice = function(x, choices, .var.name) {
  res = checkChoice(x, choices)
  makeAssertion(res, vname(x, .var.name))
}

#' @rdname checkChoice
#' @export
testChoice = function(x, choices) {
  res = checkChoice(x, choices)
  isTRUE(res)
}

#' @rdname checkChoice
#' @template expect
#' @export
expect_choice = function(x, choices, info = NULL, label = NULL) {
  res = checkChoice(x, choices)
  makeExpectation(res, info = info, label = vname(x, label))
}
