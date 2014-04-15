context("isCount")

test_that("isCount", {
  expect_false(isCount(integer(0)))
  expect_false(isCount(NULL))

  expect_true(isCount(1L))
  expect_true(isCount(1))
  expect_true(isCount(0))
  expect_false(isCount(-1))
  expect_false(isCount(0.5))
  expect_false(isCount(NA_integer_))
})

test_that("assertFlag", {
  expect_true(assertCount(1))
  expect_error(assertCount(NA, "count"))
})
