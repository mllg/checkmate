context("Interoperability")

test_that("data.table is supported", {
  skip_if_not_installed("data.table")
  library(data.table)
  myobj = as.data.table(iris)
  expect_succ_all(DataFrame, myobj)
  expect_true(testDataFrame(myobj, nrow = 150, min.cols = 2, any.missing = FALSE, col.names = "strict"))
  expect_true(testDataFrame(data.table()))
})

test_that("tibble is supported", {
  skip_if_not_installed("tibble")
  library(tibble)
  myobj = as_tibble(iris)
  expect_succ_all(DataFrame, myobj)
  expect_true(testDataFrame(myobj, nrow = 150, min.cols = 2, any.missing = FALSE, col.names = "strict"))
  expect_true(testDataFrame(tibble()))
})

test_that("magrittr is supported", {
  skip_if_not_installed("magrittr")
  library(magrittr)
  x = runif(10)
  expect_identical(x %>% assert_numeric(lower = 0, upper = 1), x)
  expect_identical(iris %>% assert_data_frame(min.rows = 1) %>% ncol, 5L)
})
