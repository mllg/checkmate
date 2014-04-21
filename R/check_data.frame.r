#' Check if an argument is a data frame
#'
#' @template checker
#' @inheritParams check_matrix
#' @inheritParams check_list
#' @family checker
#' @export
#' @examples
#'  test(iris, "data.frame")
#'  test(iris, "data.frame", min.rows = 1, col.names = "named")
check_data.frame = function(x, types = character(0L), min.rows, min.cols, nrows, ncols, row.names = "any", col.names = "any") {
  if (!is.data.frame(x))
    return("'%s' must be a data frame")
  check_matrix_props(x, min.rows, min.cols, nrows, ncols, row.names, col.names) %and% check_list_props(x, types)
}
