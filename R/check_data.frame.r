#' Check if an argument is a \code{data.frame}
#'
#' @template checker
#' @inheritParams check_matrix
#' @inheritParams check_list
#' @family basetypes
#' @export
#' @examples
#'  test(iris, "data.frame")
#'  test(iris, "data.frame", min.rows = 1, col.names = "named")
check_data.frame = function(x, types = character(0L), any.missing = TRUE, min.rows, min.cols, nrows, ncols, row.names = "any", col.names = "any") {
  if (!is.data.frame(x))
    return(mustBeClass("data.frame"))
  check_matrix_props(x, any.missing, min.rows, min.cols, nrows, ncols, row.names, col.names) %and% check_list_props(x, types)
}
