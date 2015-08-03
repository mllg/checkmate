#' Check if an argument is a matrix
#'
#' @templateVar fn Matrix
#' @template x
#' @template mode
#' @param any.missing [\code{logical(1)}]\cr
#'  Are missing values allowed? Default is \code{TRUE}.
#' @param all.missing [\code{logical(1)}]\cr
#'  Are matricies with only missing values allowed? Default is \code{TRUE}.
#' @param min.rows [\code{integer(1)}]\cr
#'  Minimum number of rows.
#' @param min.cols [\code{integer(1)}]\cr
#'  Minimum number of columns.
#' @param nrows [\code{integer(1)}]\cr
#'  Exact number of rows.
#' @param ncols [\code{integer(1)}]\cr
#'  Exact number of columns.
#' @param row.names [\code{character(1)}]\cr
#'  Check for row names. Default is \dQuote{NULL} (no check).
#'  See \code{\link{checkNamed}} for possible values.
#'  Note that you can use \code{\link{checkSubset}} to check for a specific set of names.
#' @param col.names [\code{character(1)}]\cr
#'  Check for column names. Default is \dQuote{NULL} (no check).
#'  See \code{\link{checkNamed}} for possible values.
#'  Note that you can use \code{\link{checkSubset}} to test for a specific set of names.
#' @template checker
#' @family basetypes
#' @useDynLib checkmate c_check_matrix
#' @export
#' @examples
#' x = matrix(1:9, 3)
#' colnames(x) = letters[1:3]
#' testMatrix(x, nrows = 3, min.cols = 1, col.names = "named")
checkMatrix = function(x, mode = NULL, any.missing = TRUE, all.missing = TRUE, min.rows = NULL, min.cols = NULL, nrows = NULL, ncols = NULL, row.names = NULL, col.names = NULL) {
  .Call("c_check_matrix", x, mode, any.missing, all.missing, min.rows, min.cols, nrows, ncols, row.names, col.names, PACKAGE = "checkmate")
}

#' @rdname checkMatrix
#' @useDynLib checkmate c_check_matrix
#' @export
assertMatrix = function(x, mode = NULL, any.missing = TRUE, all.missing = TRUE, min.rows = NULL, min.cols = NULL, nrows = NULL, ncols = NULL, row.names = NULL, col.names = NULL, add = NULL, .var.name) {
  res = .Call("c_check_matrix", x, mode, any.missing, all.missing, min.rows, min.cols, nrows, ncols, row.names, col.names, PACKAGE = "checkmate")
  makeAssertion(res, vname(x, .var.name), add)
}

#' @rdname checkMatrix
#' @useDynLib checkmate c_check_matrix
#' @export
testMatrix = function(x, mode = NULL, any.missing = TRUE, all.missing = TRUE, min.rows = NULL, min.cols = NULL, nrows = NULL, ncols = NULL, row.names = NULL, col.names = NULL) {
  res = .Call("c_check_matrix", x, mode, any.missing, all.missing, min.rows, min.cols, nrows, ncols, row.names, col.names, PACKAGE = "checkmate")
  isTRUE(res)
}

#' @rdname checkMatrix
#' @template expect
#' @useDynLib checkmate c_check_matrix
#' @export
expect_matrix = function(x, mode = NULL, any.missing = TRUE, all.missing = TRUE, min.rows = NULL, min.cols = NULL, nrows = NULL, ncols = NULL, row.names = NULL, col.names = NULL, info = NULL, label = NULL) {
  res = .Call("c_check_matrix", x, mode, any.missing, all.missing, min.rows, min.cols, nrows, ncols, row.names, col.names, PACKAGE = "checkmate")
  makeExpectation(res, info = info, label = vname(x, label))
}
