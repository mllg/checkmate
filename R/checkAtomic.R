#' Check that an argument is an atomic vector
#'
#' @description
#' For the definition of \dQuote{atomic}, see \code{\link[base]{is.atomic}}.
#'
#' Note that `NULL` is recognized as a valid atomic value, as in R versions up to version 4.3.x.
#' For details, see \url{https://stat.ethz.ch/pipermail/r-devel/2023-September/082892.html}.
#'
#' @templateVar fn Atomic
#' @template x
#' @inheritParams checkVector
#' @template checker
#' @useDynLib checkmate c_check_atomic
#' @export
#' @family basetypes
#' @family atomicvector
#' @examples
#' testAtomic(letters, min.len = 1L, any.missing = FALSE)
checkAtomic = function(x, any.missing = TRUE, all.missing = TRUE, len = NULL, min.len = NULL, max.len = NULL, unique = FALSE, names = NULL) {
  .Call(c_check_atomic, x, any.missing, all.missing, len, min.len, max.len, unique, names)
}

#' @export
#' @rdname checkAtomic
check_atomic = checkAtomic

#' @export
#' @include makeAssertion.R
#' @template assert
#' @rdname checkAtomic
assertAtomic = makeAssertionFunction(checkAtomic, c.fun = "c_check_atomic", use.namespace = FALSE)

#' @export
#' @rdname checkAtomic
assert_atomic = assertAtomic

#' @export
#' @include makeTest.R
#' @rdname checkAtomic
testAtomic = makeTestFunction(checkAtomic, c.fun = "c_check_atomic")

#' @export
#' @rdname checkAtomic
test_atomic = testAtomic

#' @export
#' @include makeExpectation.R
#' @template expect
#' @rdname checkAtomic
expect_atomic = makeExpectationFunction(checkAtomic, c.fun = "c_check_atomic", use.namespace = FALSE)
