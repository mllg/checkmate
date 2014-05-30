context("checkCount")

test_that("checkCount", {
  expect_false(testCount(integer(0)))
  expect_false(testCount(NULL))

  expect_true(testCount(0L))
  expect_false(testCount(0L, positive = TRUE))
  expect_true(testCount(1L, positive = TRUE))
  expect_true(testCount(1))
  expect_true(testCount(0))
  expect_false(testCount(-1))
  expect_false(testCount(0.5))
  expect_false(testCount(NA_integer_))
  expect_true(testCount(NA, na.ok = TRUE))
  expect_true(testCount(NA_integer_, na.ok = TRUE))
  expect_false(testCount(1:2))

  expect_true(assertCount(1))
  expect_error(assertCount(-1), ">= 0")
})
