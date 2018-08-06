#' Check if an argument is a vector of type complex
#'
#' @templateVar fn Complex
#' @template x
#' @template na-handling
#' @inheritParams checkVector
#' @template null.ok
#' @template checker
#' @family basetypes
#' @useDynLib checkmate c_check_complex
#' @export
#' @examples
#' testComplex(1)
#' testComplex(1+1i)
checkComplex = function(x, any.missing = TRUE, all.missing = TRUE, len = NULL, min.len = NULL, max.len = NULL, unique = FALSE, names = NULL, null.ok = FALSE) {
  .Call(c_check_complex, x, any.missing, all.missing, len, min.len, max.len, unique, names, null.ok)
}

#' @export
#' @rdname checkComplex
check_complex = checkComplex

#' @export
#' @include makeAssertion.R
#' @template assert
#' @rdname checkComplex
assertComplex = makeAssertionFunction(checkComplex, c.fun = "c_check_complex", use.namespace = FALSE)

#' @export
#' @rdname checkComplex
assert_complex = assertComplex

#' @export
#' @include makeTest.R
#' @rdname checkComplex
testComplex = makeTestFunction(checkComplex, c.fun = "c_check_complex")

#' @export
#' @rdname checkComplex
test_complex = testComplex

#' @export
#' @include makeExpectation.R
#' @template expect
#' @rdname checkComplex
expect_complex = makeExpectationFunction(checkComplex, c.fun = "c_check_complex", use.namespace = FALSE)
