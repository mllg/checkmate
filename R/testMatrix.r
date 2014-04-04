#' Check if an argument is a matrix
#'
#' @param x [\code{ANY}]\cr
#'  Object to check.
#' @param min.rows [\code{integer(1)}]\cr
#'  Minimum number of rows.
#' @param min.cols [\code{integer(1)}]\cr
#'  Minimum number of columns.
#' @param nrows [\code{integer(1)}]\cr
#'  Exact number of rows.
#' @param ncols [\code{integer(1)}]\cr
#'  Exact number of columns.
#' @param row.names [\code{logical(1)}]\cr
#'  Check for row names. Default is \code{FALSE}.
#' @param col.names [\code{logical(1)}]\cr
#'  Check for column names. Default is \code{FALSE}.
#' @param .var.name [\code{logical(1)}]\cr
#'  Argument name to print in error message. If missing,
#'  the name of \code{x} will be retrieved via \code{\link[base]{substitute}}.
#' @return [\code{logical(1)}] Returns \code{TRUE} on success.
#'  Throws an exception on failure for assertion.
#' @export
assertMatrix = function(x, min.rows, min.cols, nrows, ncols, row.names = FALSE, col.names = FALSE, .var.name) {
  amsg(testVectorProps(x), vname(x, .var.name))
  amsg(testList(x), vname(x, .var.name))
}

#' @rdname assertList
#' @export
checkMatrix = function(x, min.rows, min.cols, nrows, ncols, row.names = FALSE, col.names = FALSE) {
  isTRUE(testMatrixProps(x, ...)) && isTRUE(testMatrix(x))
}

testMatrix = function(x, min.rows, min.cols, nrows, ncols, row.names = FALSE, col.names = FALSE) {
  if (!is.matrix(x))
    return("'%s' must be a matrix")
  return(testMatrixProps(x, min.rows, min.cols, nrows, ncols, row.names, col.names))
}

testMatrixProps = function(x, min.rows, min.cols, nrows, ncols, row.names = FALSE, col.names = FALSE) {
  dims = dim(x)
  if (length(dims) != 2L)
    return("'%s' must have two dimensions")
  if (!missing(min.rows) && assertCount(min.rows) && min.rows > dims[1L])
    return(sprintf("'%%s' must have at least %i rows", dims[1L]))
  if (!missing(min.cols) && assertCount(min.cols) && min.cols > dims[2L])
    return(sprintf("'%%s' must have at least %i columns", dims[2L]))
  if (!missing(nrows) && assertCount(nrows) && nrows != dims[1L])
    return(sprintf("'%%s' must have at exactly %i rows", dims[1L]))
  if (!missing(ncols) && assertCount(ncols) && ncols != dims[2L])
    return(sprintf("'%%s' must have at exactly %i columns", dims[2L]))
  if (assertFlag(row.names) && row.names && !properNames(rownames(x)))
    return("'%%s' must have row names")
  if (assertFlag(col.names) && col.names && !properNames(colnames(x)))
    return("'%%s' must have column names")

  return(TRUE)
}
