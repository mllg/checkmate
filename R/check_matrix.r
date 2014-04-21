#' Check if an argument is a matrix
#'
#' @template checker
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
#'  See \code{\link{check_named}} for possible values.
#' @param col.names [\code{logical(1)}]\cr
#'  Check for column names. Default is \dQuote{any} (no check).
#'  See \code{\link{check_named}} for possible values.
#' @family checker
#' @export
check_matrix = function(x, min.rows, min.cols, nrows, ncols, row.names = "any", col.names = "any") {
  if (!is.matrix(x))
    return("'%s' must be a matrix")
  check_matrix_props(x, min.rows, min.cols, nrows, ncols, row.names, col.names)
}

check_matrix_props = function(x, min.rows, min.cols, nrows, ncols, row.names = "any", col.names = "any") {
  dims = dim(x)
  if (length(dims) != 2L)
    return("'%s' must have two dimensions")
  if (!missing(min.rows) && qassert(min.rows, "X1[0,)") && min.rows > dims[1L])
    return(sprintf("'%%s' must have at least %i rows", dims[1L]))
  if (!missing(min.cols) && qassert(min.cols, "X1[0,)") && min.cols > dims[2L])
    return(sprintf("'%%s' must have at least %i columns", dims[2L]))
  if (!missing(nrows) && qassert(nrows, "X1[0,)") && nrows != dims[1L])
    return(sprintf("'%%s' must have at exactly %i rows", dims[1L]))
  if (!missing(ncols) && qassert(ncols, "X1[0,)") && ncols != dims[2L])
    return(sprintf("'%%s' must have at exactly %i columns", dims[2L]))
  if (qassert(row.names, "S1") && row.names != "any") {
    tmp = check_names(rownames(x), type = row.names)
    if (!isTRUE(tmp))
      return(sprintf("Rows of %s", tmp))
  }
  if (qassert(col.names, "S1") && col.names != "any") {
    tmp = check_names(colnames(x), type = col.names)
    if (!isTRUE(tmp))
      return(sprintf("Columns of %s", tmp))
  }

  return(TRUE)
}
