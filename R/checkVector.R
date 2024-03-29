#' Check if an argument is a vector
#'
#' @templateVar fn Vector
#' @template x
#' @param strict [\code{logical(1)}]\cr
#'  May the vector have additional attributes? If \code{TRUE}, mimics the behavior of
#'  \code{\link[base]{is.vector}}.
#'  Default is \code{FALSE} which allows e.g. \code{factor}s or \code{data.frame}s
#'  to be recognized as vectors.
#' @param any.missing [\code{logical(1)}]\cr
#'  Are vectors with missing values allowed? Default is \code{TRUE}.
#' @param all.missing [\code{logical(1)}]\cr
#'  Are vectors with no non-missing values allowed? Default is \code{TRUE}.
#'  Note that empty vectors do not have non-missing values.
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
#'  Note that you can use \code{\link{checkSubset}} to check for a specific set of names.
#' @template null.ok
#' @template checker
#' @family basetypes
#' @family atomicvector
#' @useDynLib checkmate c_check_vector
#' @export
#' @examples
#' testVector(letters, min.len = 1L, any.missing = FALSE)
checkVector = function(x, strict = FALSE, any.missing = TRUE, all.missing = TRUE, len = NULL, min.len = NULL, max.len = NULL, unique = FALSE, names = NULL, null.ok = FALSE) {
  .Call(c_check_vector, x, strict, any.missing, all.missing, len, min.len, max.len, unique, names, null.ok)
}

#' @export
#' @rdname checkVector
check_vector = checkVector

#' @export
#' @include makeAssertion.R
#' @template assert
#' @rdname checkVector
assertVector = makeAssertionFunction(checkVector, c.fun = "c_check_vector", use.namespace = FALSE)

#' @export
#' @rdname checkVector
assert_vector = assertVector

#' @export
#' @include makeTest.R
#' @rdname checkVector
testVector = makeTestFunction(checkVector, c.fun = "c_check_vector")

#' @export
#' @rdname checkVector
test_vector = testVector
