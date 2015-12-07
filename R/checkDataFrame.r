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
