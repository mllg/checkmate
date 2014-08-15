#' Check if an argument is a vector
#'
#' @templateVar fn Vector
#' @template checker
#' @param strict [\code{logical(1)}]\cr
#'  May the vector have additional attributes or perform a
#'  check for additional attributes like \code{\link[base]{is.vector}}?
#'  Default is \code{FALSE} which allows e.g. \code{factor}s or \code{data.frame}s
#'  to be recognized as vectors.
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
#' @useDynLib checkmate c_check_vector
#' @export
#' @examples
#' testVector(letters, min.len = 1L, any.missing = FALSE)
checkVector = function(x, strict = FALSE, any.missing = TRUE, all.missing = TRUE, len = NULL, min.len = NULL, max.len = NULL, unique = FALSE, names = NULL) {
  .Call("c_check_vector", strict, x, any.missing, all.missing, len, min.len, max.len, unique, names, PACKAGE = "checkmate")
}

#' @rdname checkVector
#' @useDynLib checkmate c_check_vector
#' @export
assertVector = function(x, strict = FALSE, any.missing = TRUE, all.missing = TRUE, len = NULL, min.len = NULL, max.len = NULL, unique = FALSE, names = NULL, .var.name) {
  res = .Call("c_check_vector", x, strict, any.missing, all.missing, len, min.len, max.len, unique, names, PACKAGE = "checkmate")
  makeAssertion(res, vname(x, .var.name))
}

#' @rdname checkVector
#' @useDynLib checkmate c_check_vector
#' @export
testVector = function(x, strict = FALSE, any.missing = TRUE, all.missing = TRUE, len = NULL, min.len = NULL, max.len = NULL, unique = FALSE, names = NULL) {
  isTRUE(.Call("c_check_vector", x, strict, any.missing, all.missing, len, min.len, max.len, unique, names, PACKAGE = "checkmate"))
}
