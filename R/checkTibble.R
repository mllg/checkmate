#' Check if an argument is a tibble
#'
#' @templateVar fn Tibble
#' @template x
#' @inheritParams checkMatrix
#' @inheritParams checkList
#' @inheritParams checkDataFrame
#' @template null.ok
#' @template checker
#' @family compound
#' @export
#' @examples
#' library(tibble)
#' x = as_tibble(iris)
#' testTibble(x)
#' testTibble(x, nrow = 150, any.missing = FALSE)
checkTibble = function(x, types = character(0L), any.missing = TRUE, all.missing = TRUE, min.rows = NULL, min.cols = NULL, nrows = NULL, ncols = NULL, row.names = NULL, col.names = NULL, null.ok = FALSE) {
  if (is.null(x)) {
    if (identical(null.ok, TRUE))
      return(TRUE)
    return("Must be a tibble, not 'NULL'")
  }
  if (!inherits(x, "tbl_df"))
    return(paste0("Must be a tibble", if (isTRUE(null.ok)) " (or 'NULL')" else "", sprintf(", not %s", guessType(x))))
  checkDataFrame(x, types, any.missing, all.missing, min.rows, min.cols, nrows, ncols, row.names, col.names, null.ok)
}

#' @export
#' @rdname checkTibble
check_tibble = checkTibble

#' @export
#' @include makeAssertion.R
#' @template assert
#' @rdname checkTibble
assertTibble = makeAssertionFunction(checkTibble)

#' @export
#' @rdname checkTibble
assert_tibble = assertTibble

#' @export
#' @include makeTest.R
#' @rdname checkTibble
testTibble = makeTestFunction(checkTibble)

#' @export
#' @rdname checkTibble
test_tibble = testTibble

#' @export
#' @include makeExpectation.R
#' @template expect
#' @rdname checkTibble
expect_tibble = makeExpectationFunction(checkTibble)
