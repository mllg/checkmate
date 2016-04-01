context("checkDataFrame")

test_that("checkDataTable", {
  skip_if_not_installed("data.table")
  library(data.table)

  dt = as.data.table(iris)
  expect_succ_all("DataTable", dt)
  expect_fail_all("DataTable", iris)

  expect_true(testDataTable(dt, min.rows = 1, ncols = 5))
  expect_false(testDataTable(dt, min.rows = 1000, ncols = 5))

  expect_true(testDataTable(dt, key = character(0)))
  expect_true(testDataTable(dt, index = character(0)))

  setkeyv(dt, "Species")
  expect_true(testDataTable(dt, key = "Species"))
  expect_false(testDataTable(dt, index = "Species"))

  dt = as.data.table(iris)
  setkeyv(dt, "Species", physical = FALSE)
  expect_false(testDataTable(dt, key = "Species"))
  expect_true(testDataTable(dt, index = "Species"))

  dt = as.data.table(iris)
  setkeyv(dt, c("Petal.Width", "Petal.Length"), physical = TRUE)
  setkeyv(dt, c("Sepal.Length", "Sepal.Width"), physical = FALSE)
  expect_true(testDataTable(dt, key = c("Petal.Width", "Petal.Length"), index = c("Sepal.Width", "Sepal.Length")))

  expect_error(testDataTable(dt, key = 1), "string")
  expect_error(testDataTable(dt, index = 1), "string")
  expect_error(assertDataTable(dt, key = "Species"), "primary keys")
  expect_error(assertDataTable(dt, index = "Species"), "secondary keys")
})
