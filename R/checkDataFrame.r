#' Check if an argument is a \code{data.frame}
#'
#' @templateVar fn DataFrame
#' @template checker
#' @inheritParams checkMatrix
#' @inheritParams checkList
#' @family basetypes
#' @export
#' @examples
#'  test(iris, "data.frame")
#'  test(iris, "data.frame", min.rows = 1, col.names = "named")
checkDataFrame = function(x, types = character(0L), any.missing = TRUE, min.rows = NULL, min.cols = NULL, nrows = NULL, ncols = NULL, row.names = "any", col.names = "any") {
  if (!is.data.frame(x))
    return("Must be a data.frame")
  checkMatrixProps(x, any.missing, min.rows, min.cols, nrows, ncols, row.names, col.names) %and% checkListProps(x, types)
}

#' @rdname checkDataFrame
#' @export
assertDataFrame = function(x, types = character(0L), any.missing = TRUE, min.rows = NULL, min.cols = NULL, nrows = NULL, ncols = NULL, row.names = "any", col.names = "any", .var.name) {
  makeAssertion(checkDataFrame(x, types, any.missing, min.rows, min.cols, nrows, ncols, row.names, col.names), vname(x, .var.name))
}

#' @rdname checkDataFrame
#' @export
testDataFrame = function(x, types = character(0L), any.missing = TRUE, min.rows = NULL, min.cols = NULL, nrows = NULL, ncols = NULL, row.names = "any", col.names = "any") {
  makeTest(checkDataFrame(x, types, any.missing, min.rows, min.cols, nrows, ncols, row.names, col.names))
}
