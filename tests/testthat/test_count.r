context("check_count")

test_that("check_count", {
  expect_false(test(integer(0), "count"))
  expect_false(test(NULL, "count"))

  expect_true(test(1L, "count"))
  expect_true(test(1, "count"))
  expect_true(test(0, "count"))
  expect_false(test(-1, "count"))
  expect_false(test(0.5, "count"))
  expect_false(test(NA_integer_, "count"))
  expect_true(test(NA, "count", na.ok = TRUE))
  expect_true(test(NA_integer_, "count", na.ok = TRUE))

  expect_true(assert(1, "count"))
  expect_error(assert(-1, "count"), ">= 0")
})
