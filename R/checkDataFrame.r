#' Check if an argument is a data frame
#'
#' @templateVar fn DataFrame
#' @template checker
#' @inheritParams checkMatrix
#' @inheritParams checkList
#' @family basetypes
#' @export
#' @useDynLib checkmate c_check_dataframe
#' @examples
#' testDataFrame(iris, "data.frame")
#' testDataFrame(iris, "data.frame", min.rows = 1, col.names = "named")
checkDataFrame = function(x, types = character(0L), any.missing = TRUE, min.rows = NULL, min.cols = NULL, nrows = NULL, ncols = NULL, row.names = NULL, col.names = NULL) {
  .Call("c_check_dataframe", x, any.missing, min.rows, min.cols, nrows, ncols, row.names, col.names, PACKAGE = "checkmate") %and%
  checkListProps(x, types)
}

#' @rdname checkDataFrame
#' @useDynLib checkmate c_check_dataframe
#' @export
assertDataFrame = function(x, types = character(0L), any.missing = TRUE, min.rows = NULL, min.cols = NULL, nrows = NULL, ncols = NULL, row.names = NULL, col.names = NULL, .var.name) {
  res = .Call("c_check_dataframe", x, any.missing, min.rows, min.cols, nrows, ncols, row.names, col.names, PACKAGE = "checkmate")
  makeAssertion(res, vname(x, .var.name))
  res = checkListProps(x, types)
  makeAssertion(res, vname(x, .var.name))
}

#' @rdname checkDataFrame
#' @useDynLib checkmate c_check_dataframe
#' @export
testDataFrame = function(x, types = character(0L), any.missing = TRUE, min.rows = NULL, min.cols = NULL, nrows = NULL, ncols = NULL, row.names = NULL, col.names = NULL) {
  isTRUE(.Call("c_check_dataframe", x, any.missing, min.rows, min.cols, nrows, ncols, row.names, col.names, PACKAGE = "checkmate")) &&
  isTRUE(checkListProps(x, types))
}
