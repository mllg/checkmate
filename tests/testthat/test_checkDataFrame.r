context("checkDataFrame")

test_that("checkDataFrame", {
  myobj = iris
  expect_succ(DataFrame, myobj)
  myobj = TRUE
  expect_fail(DataFrame, myobj)

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
  expect_error(assertDataFrame(1), "data frame")
  expect_error(assertDataFrame(x, types = "numeric"), "types: numeric")
})


test_that("checkDataFrame name checking works", {
  df = data.frame(x = 1:2, y = 1:2)
  names(df) = c("x", "x")
  expect_true(assertDataFrame(df))
  expect_error(assertDataFrame(df, col.names = "unnamed"), "unnamed")

  names(df) = c("x", "")
  expect_error(assertDataFrame(df, col.names = "named"), "named")

  names(df) = c("x", "x")
  expect_true(assertDataFrame(df, col.names = "named"))
  expect_error(assertDataFrame(df, col.names = "unique"), "uniquely")
  expect_error(assertDataFrame(df, col.names = "strict"), "uniquely")

  names(df) = c("x", "1")
  expect_true(assertDataFrame(df, col.names = "named"))
  expect_true(assertDataFrame(df, col.names = "unique"))
  expect_error(assertDataFrame(df, col.names = "strict"), "naming rules")

  rownames(df) = NULL
  expect_error(assertDataFrame(df, row.names = "unnamed"), "unnamed")
  expect_true(assertDataFrame(df, row.names = "named"))
  expect_error(assertDataFrame(df, row.names = "strict"), "naming rules")
})
