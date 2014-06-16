#' Check that an argument is an atomic vector
#'
#' An atomic vector is defined slightly different from specifications in
#' \code{\link[base]{is.atomic}} and \code{\link[base]{is.vector}}:
#' An atomic vector is either \code{logical}, \code{integer}, \code{numeric},
#' \code{complex}, \code{character} or \code{raw} and can have any attributes.
#' I.e., a \code{factor} is an atomic vector, but \code{NULL} is not.
#' In short, this is equivalent to \code{is.atomic(x) && !is.null(x)}.
#'
#' @templateVar fn AtomicVector
#' @template checker
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
#' @family basetypes
#' @useDynLib checkmate c_check_atomic_vector
#' @export
#' @examples
#'  testAtomicVector(letters, min.len = 1L, any.missing = FALSE)
checkAtomicVector = function(x, any.missing = TRUE, all.missing = TRUE, len = NULL, min.len = NULL, max.len = NULL, unique = FALSE, names = NULL) {
  .Call("c_check_atomic_vector", x, any.missing, all.missing, len, min.len, max.len, unique, names, PACKAGE = "checkmate")
}

#' @rdname checkAtomicVector
#' @useDynLib checkmate c_check_atomic_vector
#' @export
assertAtomicVector = function(x, any.missing = TRUE, all.missing = TRUE, len = NULL, min.len = NULL, max.len = NULL, unique = FALSE, names = NULL, .var.name) {
  makeAssertion(
    .Call("c_check_atomic_vector", x, any.missing, all.missing, len, min.len, max.len, unique, names, PACKAGE = "checkmate")
  , vname(x, .var.name))
}

#' @rdname checkAtomicVector
#' @useDynLib checkmate c_check_atomic_vector
#' @export
testAtomicVector = function(x, any.missing = TRUE, all.missing = TRUE, len = NULL, min.len = NULL, max.len = NULL, unique = FALSE, names = NULL) {
  isTRUE(
    .Call("c_check_atomic_vector", x, any.missing, all.missing, len, min.len, max.len, unique, names, PACKAGE = "checkmate")
  )
}
