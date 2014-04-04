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
#'  Check for row names. Default is \dQuote{any} (no check).
#'  See \code{\link{checkNames}} for possible values.
#' @param col.names [\code{logical(1)}]\cr
#'  Check for column names. Default is \dQuote{any} (no check).
#'  See \code{\link{checkNames}} for possible values.
#' @param .var.name [\code{logical(1)}]\cr
#'  Argument name to print in error message. If missing,
#'  the name of \code{x} will be retrieved via \code{\link[base]{substitute}}.
#' @return [\code{logical(1)}] Returns \code{TRUE} on success.
#'  Throws an exception on failure for assertion.
#' @export
assertMatrix = function(x, min.rows, min.cols, nrows, ncols, row.names = "any", col.names = "any", .var.name) {
  amsg(testMatrixProps(x, min.rows, min.cols, nrows, ncols, row.names, col.names), vname(x, .var.name))
  amsg(testMatrix(x), vname(x, .var.name))
}

#' @rdname assertList
#' @export
checkMatrix = function(x, min.rows, min.cols, nrows, ncols, row.names = "any", col.names = "any") {
  isTRUE(testMatrixProps(x, min.rows, min.cols, nrows, ncols, row.names, col.names)) && isTRUE(testMatrix(x))
}

testMatrix = function(x) {
  if (!is.matrix(x))
    return("'%s' must be a matrix")
  return(TRUE)
}

testMatrixProps = function(x, min.rows, min.cols, nrows, ncols, row.names = "any", col.names = "any") {
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
  if (qassert(row.names, "S1") && row.names != "any") {
    tmp = testNames(rownames(x), type = row.names)
    if (!isTRUE(tmp))
      return(sprintf("Rows of %s", tmp))
  }
  if (qassert(col.names, "S1") && col.names != "any") {
    tmp = testNames(colnames(x), type = col.names)
    if (!isTRUE(tmp))
      return(sprintf("Columns of %s", tmp))
  }

  return(TRUE)
}
