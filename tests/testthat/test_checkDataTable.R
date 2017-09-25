context("checkDataTable")

test_that("checkDataTable", {
  skip_if_not_physically_installed("data.table")

  expect_false(testDataTable(iris))
  expect_true("data.table" %in% loadedNamespaces())

  dt = data.table::as.data.table(iris)
  expect_succ_all("DataFrame", dt)
  expect_succ_all("DataTable", dt)
  expect_fail_all("DataTable", iris)

  expect_true(testDataTable(dt, min.rows = 1, ncols = 5))
  expect_false(testDataTable(dt, min.rows = 1000, ncols = 5))

  expect_true(testDataTable(dt, key = character(0)))
  expect_true(testDataTable(dt, index = character(0)))

  data.table::setkeyv(dt, "Species")
  expect_true(testDataTable(dt, key = "Species"))
  expect_false(testDataTable(dt, index = "Species"))

  dt = data.table::as.data.table(iris)
  data.table::setkeyv(dt, "Species", physical = FALSE)
  expect_false(testDataTable(dt, key = "Species"))
  expect_true(testDataTable(dt, index = "Species"))

  dt = data.table::as.data.table(iris)
  data.table::setkeyv(dt, c("Petal.Width", "Petal.Length"), physical = TRUE)
  data.table::setkeyv(dt, c("Sepal.Length", "Sepal.Width"), physical = FALSE)
  expect_true(testDataTable(dt, key = c("Petal.Width", "Petal.Length"), index = c("Sepal.Width", "Sepal.Length")))

  expect_error(testDataTable(dt, key = 1), "string")
  expect_error(testDataTable(dt, index = 1), "string")
  expect_error(assertDataTable(dt, key = "Species"), "primary keys")
  expect_error(assertDataTable(dt, index = "Species"), "secondary keys")
})
