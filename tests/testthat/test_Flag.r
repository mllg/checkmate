context("isFlag")

test_that("isFlag", {
  expect_false(isFlag(logical(0)))
  expect_false(isFlag(NULL))
  expect_true(isFlag(TRUE))
  expect_true(isFlag(FALSE))
  expect_false(isFlag(NA))
  expect_true(isFlag(NA, na.ok=TRUE))
  expect_false(isFlag(iris, na.ok=TRUE))
})

test_that("assertFlag", {
  expect_true(assertFlag(TRUE))
  expect_error(assertFlag(1, "flag"))
})
