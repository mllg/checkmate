context("checkDataFrame")

test_that("checkDataFrame", {
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

  y = data.frame(TRUE)
  expect_true(assertDataFrame(y))
  expect_error(assert(1))

  expect_true(assertDataFrame(x, types = c("numeric", "factor")))
  expect_error(assertDataFrame(x, types = "numeric"), "types: numeric")
})
