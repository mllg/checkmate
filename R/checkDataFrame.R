#' Check if an argument is a data frame
#'
#' @templateVar fn DataFrame
#' @template x
#' @inheritParams checkMatrix
#' @inheritParams checkList
#' @template null.ok
#' @template checker
#' @family basetypes
#' @export
#' @useDynLib checkmate c_check_dataframe
#' @examples
#' testDataFrame(iris)
#' testDataFrame(iris, types = c("numeric", "factor"), min.rows = 1, col.names = "named")
checkDataFrame = function(x, types = character(0L), any.missing = TRUE, all.missing = TRUE, min.rows = NULL, min.cols = NULL, nrows = NULL, ncols = NULL, row.names = NULL, col.names = NULL, null.ok = FALSE) {
  .Call(c_check_dataframe, x, any.missing, all.missing, min.rows, min.cols, nrows, ncols, row.names, col.names, null.ok) %and%
  checkListTypes(x, types)
}

#' @export
#' @rdname checkDataFrame
check_data_frame = checkDataFrame

#' @export
#' @include makeAssertion.R
#' @template assert
#' @rdname checkDataFrame
assertDataFrame = makeAssertionFunction(checkDataFrame)

#' @export
#' @rdname checkDataFrame
assert_data_frame = assertDataFrame

#' @export
#' @include makeTest.R
#' @rdname checkDataFrame
testDataFrame = makeTestFunction(checkDataFrame)

#' @export
#' @rdname checkDataFrame
test_data_frame = testDataFrame

#' @export
#' @include makeExpectation.R
#' @template expect
#' @rdname checkDataFrame
expect_data_frame = makeExpectationFunction(checkDataFrame)
