#' Check if an argument is a data table
#'
#' @templateVar fn DataTable
#' @template x
#' @inheritParams checkMatrix
#' @inheritParams checkList
#' @inheritParams checkDataFrame
#' @param key [\code{character}]\cr
#'   Expected primary key(s) of the data table.
#' @param index [\code{character}]\cr
#'   Expected secondary key(s) of the data table.
#' @template checker
#' @family basetypes
#' @export
#' @examples
#' library(data.table)
#' dt = as.data.table(iris)
#' setkeyv(dt, "Species")
#' setkeyv(dt, "Sepal.Length", physical = FALSE)
#' testDataTable(dt)
#' testDataTable(dt, key = "Species", index = "Sepal.Length", any.missing = FALSE)
checkDataTable = function(x, key = NULL, index = NULL, types = character(0L), any.missing = TRUE, all.missing = TRUE, min.rows = NULL, min.cols = NULL, nrows = NULL, ncols = NULL, row.names = NULL, col.names = NULL) {
  if (!requireNamespace("data.table", quietly = TRUE))
    stop("Install 'data.table' to perform checks in data tables")

  if (!data.table::is.data.table(x)) {
    return("Must be a data.table")
  }

  if (!is.null(key)) {
    qassert(key, "S")
    if (!setequal(data.table::key(x) %??% character(0L), key))
      return(sprintf("Must have primary keys: %s", collapse(key)))
  }

  if (!is.null(index)) {
    qassert(index, "S")
    indices = strsplit(data.table::key2(x) %??% "", "__", fixed = TRUE)[[1L]]
    if (!setequal(indices, index))
      return(sprintf("Must have secondary keys (indices): %s", collapse(index)))
  }

  checkDataFrame(x, types, any.missing, all.missing, min.rows, min.cols, nrows, ncols, row.names, col.names)
}

#' @export
#' @include makeAssertion.r
#' @template assert
#' @rdname checkDataTable
assertDataTable = makeAssertionFunction(checkDataTable)

#' @export
#' @rdname checkDataTable
assert_data_table = assertDataTable

#' @export
#' @include makeTest.r
#' @rdname checkDataTable
testDataTable = makeTestFunction(checkDataTable)

#' @export
#' @rdname checkDataTable
test_data_table = testDataTable

#' @export
#' @include makeExpectation.r
#' @template expect
#' @rdname checkDataTable
expect_data_table = makeExpectationFunction(checkDataTable)
