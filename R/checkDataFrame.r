#' Check if an argument is a data frame
#'
#' @templateVar fn DataFrame
#' @template x
#' @inheritParams checkMatrix
#' @inheritParams checkList
#' @template checker
#' @family basetypes
#' @export
#' @useDynLib checkmate c_check_dataframe
#' @examples
#' testDataFrame(iris)
#' testDataFrame(iris, types = c("numeric", "factor"), min.rows = 1, col.names = "named")
checkDataFrame = function(x, types = character(0L), any.missing = TRUE, all.missing = TRUE, min.rows = NULL, min.cols = NULL, nrows = NULL, ncols = NULL, row.names = NULL, col.names = NULL) {
  .Call("c_check_dataframe", x, any.missing, all.missing, min.rows, min.cols, nrows, ncols, row.names, col.names, PACKAGE = "checkmate") %and%
  checkListProps(x, types)
}

#' @rdname checkDataFrame
#' @useDynLib checkmate c_check_dataframe
#' @export
assertDataFrame = function(x, types = character(0L), any.missing = TRUE, all.missing = TRUE, min.rows = NULL, min.cols = NULL, nrows = NULL, ncols = NULL, row.names = NULL, col.names = NULL, .var.name) {
  res = .Call("c_check_dataframe", x, any.missing, all.missing, min.rows, min.cols, nrows, ncols, row.names, col.names, PACKAGE = "checkmate")
  makeAssertion(res, vname(x, .var.name))
  res = checkListProps(x, types)
  makeAssertion(res, vname(x, .var.name))
}

#' @rdname checkDataFrame
#' @useDynLib checkmate c_check_dataframe
#' @export
testDataFrame = function(x, types = character(0L), any.missing = TRUE, all.missing = TRUE, min.rows = NULL, min.cols = NULL, nrows = NULL, ncols = NULL, row.names = NULL, col.names = NULL) {
  res = .Call("c_check_dataframe", x, any.missing, all.missing, min.rows, min.cols, nrows, ncols, row.names, col.names, PACKAGE = "checkmate")
  isTRUE(res) && isTRUE(checkListProps(x, types))
}

#' @rdname checkDataFrame
#' @template expect
#' @useDynLib checkmate c_check_dataframe
#' @export
expect_data_frame = function(x, types = character(0L), any.missing = TRUE, all.missing = TRUE, min.rows = NULL, min.cols = NULL, nrows = NULL, ncols = NULL, row.names = NULL, col.names = NULL, info = NULL, label = NULL) {
  res = .Call("c_check_dataframe", x, any.missing, all.missing, min.rows, min.cols, nrows, ncols, row.names, col.names, PACKAGE = "checkmate") %and% checkListProps(x, types)
  makeExpectation(res, info = info, label = vname(x, label))
}
