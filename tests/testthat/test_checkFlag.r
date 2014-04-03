context("checkFlag")

test_that("checkFlag", {
  expect_true(checkFlag(TRUE))
  expect_true(checkFlag(FALSE))
  expect_false(checkFlag(NA))
  expect_true(checkFlag(NA, na.ok=TRUE))
  expect_false(checkFlag(iris, na.ok=TRUE))
})

test_that("assertFlag", {
  expect_true(assertFlag(TRUE))
  expect_error(assertFlag(1, "flag"))
})
