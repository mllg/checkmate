#' Check if an argument is a matrix
#'
#' @templateVar fn Matrix
#' @template checker
#' @param mode [\code{character(1)}]\cr
#'  Storage mode of the matrix. Matricies can hold \dQuote{logical},
#'  \dQuote{integer}, \dQuote{double}, \dQuote{numeric}, \dQuote{complex} and
#'  \dQuote{character}. Default is \code{NULL} (no check).
#' @param any.missing [\code{logical(1)}]\cr
#'  Are missing values allowed? Default is \code{TRUE}.
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
#' @param col.names [\code{character(1)}]\cr
#'  Check for column names. Default is \dQuote{NULL} (no check).
#'  See \code{\link{checkNamed}} for possible values.
#' @family basetypes
#' @useDynLib checkmate c_check_matrix
#' @export
#' @examples
#'  x = matrix(1:9, 3)
#'  colnames(x) = letters[1:3]
#'  testMatrix(x, nrows = 3, min.cols = 1, col.names = "named")
checkMatrix = function(x, mode = NULL, any.missing = TRUE, min.rows = NULL, min.cols = NULL, nrows = NULL, ncols = NULL, row.names = NULL, col.names = NULL) {
  .Call("c_check_matrix", x, mode, any.missing, min.rows, min.cols, nrows, ncols, row.names, col.names, PACKAGE = "checkmate")
}

#' @rdname checkMatrix
#' @useDynLib checkmate c_check_matrix
#' @export
assertMatrix = function(x, mode = NULL, any.missing = TRUE, min.rows = NULL, min.cols = NULL, nrows = NULL, ncols = NULL, row.names = NULL, col.names = NULL, .var.name) {
  res = .Call("c_check_matrix", x, mode, any.missing, min.rows, min.cols, nrows, ncols, row.names, col.names, PACKAGE = "checkmate")
  makeAssertion(res, vname(x, .var.name))
}

#' @rdname checkMatrix
#' @useDynLib checkmate c_check_matrix
#' @export
testMatrix = function(x, mode = NULL, any.missing = TRUE, min.rows = NULL, min.cols = NULL, nrows = NULL, ncols = NULL, row.names = NULL, col.names = NULL) {
  isTRUE(.Call("c_check_matrix", x, mode, any.missing, min.rows, min.cols, nrows, ncols, row.names, col.names, PACKAGE = "checkmate"))
}
