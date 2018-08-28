#' Check if an argument is a formula
#'
#' @templateVar fn Formula
#' @template x
#' @template null.ok
#' @template checker
#' @family basetypes
#' @export
#' @examples
#' f = Species ~ Sepal.Length + Sepal.Width
#' checkFormula(f)
checkFormula = function(x, null.ok = FALSE) {
  if (is.null(x)) {
    if (null.ok)
      return(TRUE)
    return("Must be a formula, not 'NULL'")
  }

  if (!inherits(x, "formula"))
    return(sprintf("Must be a formula%s, not %s", if (null.ok) " (or 'NULL')" else "", guessType(x)))

  # if (!is.null(response)) {
  #   qassert(response, "B1")

  #   if (response) {
  #     if (length(lhs.formula(f)) == 0L)
  #       return("Must have response (left hand side)")
  #   } else {
  #     if (length(lhs.formula(f)) > 0L)
  #       return("May not have a response (left hand side)")
  #   }
  # }

  return(TRUE)
}

# lhs.formula = function(x) {
#   if (length(x) == 2L) character(0L) else all.vars(x[[2L]])
# }

# rhs.formula = function(x) {
#   all.vars(x[[length(x)]])
# }


#' @export
#' @rdname checkFormula
check_formula = checkFormula

#' @export
#' @include makeAssertion.R
#' @template assert
#' @rdname checkFormula
assertFormula = makeAssertionFunction(checkFormula, use.namespace = FALSE)

#' @export
#' @rdname checkFormula
assert_formula = assertFormula

#' @export
#' @include makeTest.R
#' @rdname checkFormula
testFormula = makeTestFunction(checkFormula)

#' @export
#' @rdname checkFormula
test_formula = testFormula

#' @export
#' @include makeExpectation.R
#' @template expect
#' @rdname checkFormula
expect_formula = makeExpectationFunction(checkFormula, use.namespace = FALSE)
