#' Check the class membership of an argument
#'
#' @templateVar fn MultiClass
#' @template x
#' @param classes [\code{character}]\cr
#'  Class names to check for inheritance with \code{\link[base]{inherits}}.
#'  \code{x} must inherit from any of the specified classes.
#' @template null.ok
#' @template checker
#' @family attributes
#' @family classes
#' @export
#' @examples
#' x = 1
#' class(x) = "bar"
#' checkMultiClass(x, c("foo", "bar"))
#' checkMultiClass(x, c("foo", "foobar"))
checkMultiClass = function(x, classes, null.ok = FALSE) {
  qassert(classes, "S+")
  qassert(null.ok, "B1")
  if (is.null(x) && null.ok)
    return(TRUE)
  if (!inherits(x, classes)) {
    cl = class(x)
    return(sprintf("Must inherit from class '%s', but has class%s '%s'",
        paste0(classes, collapse = "'/'"), if (length(cl) > 1L) "es" else "", paste0(cl, collapse = "','")))
  }
  return(TRUE)
}

#' @export
#' @rdname checkMultiClass
check_multi_class = checkMultiClass

#' @export
#' @include makeAssertion.R
#' @template assert
#' @rdname checkMultiClass
assertMultiClass = makeAssertionFunction(checkMultiClass, use.namespace = FALSE)

#' @export
#' @rdname checkMultiClass
assert_multi_class = assertMultiClass

#' @export
#' @include makeTest.R
#' @rdname checkMultiClass
testMultiClass = makeTestFunction(checkMultiClass)

#' @export
#' @rdname checkMultiClass
test_multi_class = testMultiClass

#' @export
#' @include makeExpectation.R
#' @template expect
#' @rdname checkMultiClass
expect_multi_class = makeExpectationFunction(checkMultiClass, use.namespace = FALSE)
