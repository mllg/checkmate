context("checkCount")

test_that("checkCount", {
  expect_false(checkCount(integer(0)))
  expect_false(checkCount(NULL))

  expect_true(checkCount(1L))
  expect_true(checkCount(1))
  expect_true(checkCount(0))
  expect_false(checkCount(-1))
  expect_false(checkCount(0.5))
  expect_false(checkCount(NA_integer_))
})

test_that("assertFlag", {
  expect_true(assertCount(1))
  expect_error(assertCount(NA, "count"))
})
