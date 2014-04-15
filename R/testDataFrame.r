#' Check if an argument is a data frame
#'
#' @templateVar id DataFrame
#' @template testfuns
#' @inheritParams assertMatrix
#' @inheritParams assertList
#' @family basetypes
#' @export
assertDataFrame = function(x, types = character(0L), min.rows, min.cols, nrows, ncols, row.names = "any", col.names = "any", .var.name) {
  amsg(testDataFrame(x, min.rows, min.cols, nrows, ncols, row.names, col.names), vname(x, .var.name))
}

#' @rdname assertDataFrame
#' @export
isDataFrame = function(x, types = character(0L), min.rows, min.cols, nrows, ncols, row.names = "any", col.names = "any") {
  isTRUE(testDataFrame(x, min.rows, min.cols, nrows, ncols, row.names, col.names))
}

#' @rdname assertDataFrame
#' @export
asDataFrame = function(x, types = character(0L), min.rows, min.cols, nrows, ncols, row.names = "any", col.names = "any", .var.name) {
  assertDataFrame(x, min.rows, min.cols, nrows, ncols, row.names, col.names, .var.name = vname(x, .var.name))
  x
}

testDataFrame = function(x, types = character(0L), min.rows, min.cols, nrows, ncols, row.names = "any", col.names = "any") {
  if (!is.data.frame(x))
    return("'%s' must be a data frame")
  testMatrixProps(x, min.rows, min.cols, nrows, ncols, row.names, col.names) %and% testListProps(x, types)
}
