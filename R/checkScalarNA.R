#' Check if an argument is a single missing value
#'
#' @templateVar fn ScalarNA
#' @template x
#' @template null.ok
#' @template checker
#' @family scalars
#' @export
#' @examples
#' testScalarNA(1)
#' testScalarNA(NA_real_)
#' testScalarNA(rep(NA, 2))
checkScalarNA = function(x, null.ok = FALSE) {
  qassert(null.ok, "B1")
  if (is.null(x)) {
    if (null.ok)
      return(TRUE)
    return("Must be a scalar missing value, not 'NULL'")
  }
  if (!is.atomic(x) || length(x) != 1L || !is.na(x))
    return(paste0("Must be a scalar missing value", if (null.ok) " (or 'NULL')" else ""))
  return(TRUE)
}

#' @export
#' @rdname checkScalarNA
check_scalar_na = checkScalarNA

#' @export
#' @include makeAssertion.R
#' @template assert
#' @rdname checkScalarNA
assertScalarNA = makeAssertionFunction(checkScalarNA, use.namespace = FALSE)

#' @export
#' @rdname checkScalarNA
assert_scalar_na = assertScalarNA

#' @export
#' @include makeTest.R
#' @rdname checkScalarNA
testScalarNA = makeTestFunction(checkScalarNA)

#' @export
#' @rdname checkScalarNA
test_scalar_na = testScalarNA

#' @export
#' @include makeExpectation.R
#' @template expect
#' @rdname checkScalarNA
expect_scalar_na = makeExpectationFunction(checkScalarNA, use.namespace = FALSE)
