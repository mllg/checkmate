context("checkDataFrame")

test_that("checkDataFrame", {
  myobj = iris
  expect_succ_all(DataFrame, myobj)
  myobj = TRUE
  expect_fail_all(DataFrame, myobj)

  expect_true(testDataFrame(data.frame()))
  expect_false(testDataFrame(NULL))
  expect_true(testDataFrame(data.frame(1)))
  expect_true(testDataFrame(iris))
  expect_false(testDataFrame(list(1)))

  x = iris
  expect_true(testDataFrame(x, types = c("numeric", "factor")))
  expect_false(testDataFrame(x, types = c("integer", "factor")))
  expect_false(testDataFrame(x, types = c("numeric", "character")))
  expect_true(testDataFrame(data.frame(), types = "NULL"))

  expect_true(testDataFrame(data.frame(), types = "numeric"))
  expect_error(assertDataFrame(1), "data.frame")
  expect_error(assertDataFrame(x, types = "numeric"), "types: numeric")

  # check nrow and ncol constraints
  expect_true(testDataFrame(x, nrows = 150L, ncols = 5L))
  expect_false(testDataFrame(x, nrows = 150L, ncols = 7L))
  expect_true(testDataFrame(x, min.rows = 2L, min.cols = 4L))
  expect_false(testDataFrame(x, min.rows = 151L, min.cols = 4L))
  expect_false(testDataFrame(x, min.rows = 1L, min.cols = 6L))
  expect_true(testDataFrame(x, max.rows = 200L))
  expect_false(testDataFrame(x, max.rows = 100L))
  expect_true(testDataFrame(x, max.cols = 10L))
  expect_false(testDataFrame(x, max.cols = 2L))
})


test_that("checkDataFrame name checking works", {
  df = data.frame(x = 1:2, y = 1:2)
  names(df) = c("x", "x")
  expect_identical(assertDataFrame(df), df)
  expect_error(assertDataFrame(df, col.names = "unnamed"), "colnames")

  names(df) = c("x", "")
  expect_error(assertDataFrame(df, col.names = "named"), "empty")

  names(df) = c("x", "x")
  expect_identical(assertDataFrame(df, col.names = "named"), df)
  expect_error(assertDataFrame(df, col.names = "unique"), "duplicated")
  expect_error(assertDataFrame(df, col.names = "strict"), "duplicated")
  expect_error(assertDataFrame(df, col.names = "foo"), "type")

  names(df) = c("x", "1")
  expect_identical(assertDataFrame(df, col.names = "named"), df)
  expect_identical(assertDataFrame(df, col.names = "unique"), df)
  expect_error(assertDataFrame(df, col.names = "strict"), "naming conventions")

  rownames(df) = letters[1:2]
  expect_succ_all(DataFrame, df, row.names = "strict")
  expect_succ_all(DataFrame, df, row.names = "unique")
  expect_succ_all(DataFrame, df, row.names = "named")
  expect_fail_all(DataFrame, df, row.names = "unnamed")

  rownames(df) = NULL
  expect_fail_all(DataFrame, df, row.names = "unnamed") # no names defaults to as.character(seq_row(x))
  expect_succ_all(DataFrame, df, row.names = "named")
  expect_succ_all(DataFrame, df, row.names = "unique")
  expect_fail_all(DataFrame, df, row.names = "strict")
})

test_that("dimension checks work for empty frames", {
  x = iris[, -c(1:5)]
  expect_true(testDataFrame(x, min.rows = 5))
  expect_true(testDataFrame(x, max.rows = 200))
  expect_false(testDataFrame(x, max.rows = 100))
  expect_true(testDataFrame(x, nrows = 150))
  expect_false(testDataFrame(x, min.rows = 151))
  expect_false(testDataFrame(x, nrows = 1))

  x = iris[-c(1:150), ]
  expect_true(testDataFrame(x, min.cols = 1))
  expect_true(testDataFrame(x, max.cols = 5))
  expect_false(testDataFrame(x, max.cols = 2))
  expect_true(testDataFrame(x, ncols = 5))
  expect_false(testDataFrame(x, min.cols = 6))
  expect_false(testDataFrame(x, ncols = 1))
})

test_that("missing values are detected", {
  x = data.frame(a = 1:2, b = c(1, 2))
  expect_true(testDataFrame(x, any.missing = FALSE))
  expect_true(testDataFrame(x, all.missing = FALSE))
  x$b[1] = NA
  expect_false(testDataFrame(x, any.missing = FALSE))
  expect_true(testDataFrame(x, all.missing = FALSE))
  x$a[1] = NA
  expect_false(testDataFrame(x, any.missing = FALSE))
  expect_true(testDataFrame(x, all.missing = FALSE))
  x$b[2] = NA
  expect_false(testDataFrame(x, any.missing = FALSE))
  expect_false(testDataFrame(x, all.missing = FALSE))
})

test_that("missing locations are reported correctly", {
  x = data.frame(a = 1:2, b = 1:2); x$a[1] = NA
  expect_true(grepl("column 'a', row 1", checkDataFrame(x, any.missing = FALSE)))
  x = data.frame(a = 1:2, b = 1:2); x$b[1] = NA
  expect_true(grepl("column 'b', row 1", checkDataFrame(x, any.missing = FALSE)))
  x = data.frame(a = 1:2, b = 1:2); x$b[2] = NA
  expect_true(grepl("column 'b', row 2", checkDataFrame(x, any.missing = FALSE)))

  x = data.frame(a = 1:2, b = 1:2, c = 1:2); x$c[2] = NA
  expect_true(grepl("column 'c', row 2", checkDataFrame(x, any.missing = FALSE)))
})
