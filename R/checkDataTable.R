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
#' @template null.ok
#' @template checker
#' @family compound
#' @export
#' @examples
#' library(data.table)
#' dt = as.data.table(iris)
#' setkeyv(dt, "Species")
#' setkeyv(dt, "Sepal.Length", physical = FALSE)
#' testDataTable(dt)
#' testDataTable(dt, key = "Species", index = "Sepal.Length", any.missing = FALSE)
checkDataTable = function(x, key = NULL, index = NULL, types = character(0L), any.missing = TRUE, all.missing = TRUE, min.rows = NULL, min.cols = NULL, nrows = NULL, ncols = NULL, row.names = NULL, col.names = NULL, null.ok = FALSE) {
  if (!requireNamespace("data.table", quietly = TRUE))
    stop("Install package 'data.table' to perform checks of data tables")

  qassert(null.ok, "B1")
  if (is.null(x)) {
    if (null.ok)
      return(TRUE)
    return("Must be a data.table, not 'NULL'")
  }

  if (!data.table::is.data.table(x)) {
    return(paste0("Must be a data.table", if (null.ok) " (or 'NULL')" else "", sprintf(", not %s", guessType(x))))
  }

  checkDataFrame(x, types, any.missing, all.missing, min.rows, min.cols, nrows, ncols, row.names, col.names, null.ok = FALSE) %and%
    checkDataTableProps(x, key, index)
}

checkDataTableProps = function(x, key = NULL, index = NULL) {
  if (!is.null(key)) {
    qassert(key, "S")
    if (!setequal(data.table::key(x) %??% character(0L), key))
      return(sprintf("Must have primary keys: %s", paste0(key, collapse = ",")))
  }
  if (!is.null(index)) {
    qassert(index, "S")
    indices = strsplit(data.table::indices(x) %??% "", "__", fixed = TRUE)[[1L]]
    if (!setequal(indices, index))
      return(sprintf("Must have secondary keys (indices): %s", paste0(index, collapse = ",")))
  }
  return(TRUE)
}

#' @export
#' @rdname checkDataTable
check_data_table = checkDataTable

#' @export
#' @include makeAssertion.R
#' @template assert
#' @rdname checkDataTable
assertDataTable = makeAssertionFunction(checkDataTable)

#' @export
#' @rdname checkDataTable
assert_data_table = assertDataTable

#' @export
#' @include makeTest.R
#' @rdname checkDataTable
testDataTable = makeTestFunction(checkDataTable)

#' @export
#' @rdname checkDataTable
test_data_table = testDataTable

#' @export
#' @include makeExpectation.R
#' @template expect
#' @rdname checkDataTable
expect_data_table = makeExpectationFunction(checkDataTable)
