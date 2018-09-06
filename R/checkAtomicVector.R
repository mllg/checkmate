#' Check that an argument is an atomic vector
#'
#' @description
#' An atomic vector is defined slightly different from specifications in
#' \code{\link[base]{is.atomic}} and \code{\link[base]{is.vector}}:
#' An atomic vector is either \code{logical}, \code{integer}, \code{numeric},
#' \code{complex}, \code{character} or \code{raw} and can have any attributes except a
#' dimension attribute (like matrices).
#' I.e., a \code{factor} is an atomic vector, but a matrix or \code{NULL} are not.
#' In short, this is basically equivalent to \code{is.atomic(x) && !is.null(x) && is.null(dim(x))}.
#'
#' @templateVar fn AtomicVector
#' @template x
#' @param any.missing [\code{logical(1)}]\cr
#'  Are vectors with missing values allowed? Default is \code{TRUE}.
#' @param all.missing [\code{logical(1)}]\cr
#'  Are vectors with only missing values allowed? Default is \code{TRUE}.
#' @param len [\code{integer(1)}]\cr
#'  Exact expected length of \code{x}.
#' @param min.len [\code{integer(1)}]\cr
#'  Minimal length of \code{x}.
#' @param max.len [\code{integer(1)}]\cr
#'  Maximal length of \code{x}.
#' @param unique [\code{logical(1)}]\cr
#'  Must all values be unique? Default is \code{FALSE}.
#' @param names [\code{character(1)}]\cr
#'  Check for names. See \code{\link{checkNamed}} for possible values.
#'  Default is \dQuote{any} which performs no check at all.
#' @template checker
#' @family basetypes
#' @family atomicvector
#' @useDynLib checkmate c_check_atomic_vector
#' @export
#' @examples
#' testAtomicVector(letters, min.len = 1L, any.missing = FALSE)
checkAtomicVector = function(x, any.missing = TRUE, all.missing = TRUE, len = NULL, min.len = NULL, max.len = NULL, unique = FALSE, names = NULL) {
  .Call(c_check_atomic_vector, x, any.missing, all.missing, len, min.len, max.len, unique, names)
}

#' @export
#' @rdname checkAtomicVector
check_atomic_vector = checkAtomicVector

#' @export
#' @include makeAssertion.R
#' @template assert
#' @rdname checkAtomicVector
assertAtomicVector = makeAssertionFunction(checkAtomicVector, c.fun = "c_check_atomic_vector", use.namespace = FALSE)

#' @export
#' @rdname checkAtomicVector
assert_atomic_vector = assertAtomicVector

#' @export
#' @include makeTest.R
#' @rdname checkAtomicVector
testAtomicVector = makeTestFunction(checkAtomicVector, c.fun = "c_check_atomic_vector")

#' @export
#' @rdname checkAtomicVector
test_atomic_vector = testAtomicVector

#' @export
#' @include makeExpectation.R
#' @template expect
#' @rdname checkAtomicVector
expect_atomic_vector = makeExpectationFunction(checkAtomicVector, c.fun = "c_check_atomic_vector", use.namespace = FALSE)
