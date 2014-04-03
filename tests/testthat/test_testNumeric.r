context("checkNumeric")

test_that("checkNumeric", {
  expect_false(checkNumeric(TRUE))
  expect_false(checkNumeric(NA))
  expect_true(checkNumeric(1L))
  expect_true(checkNumeric(1))
  expect_true(checkNumeric(Inf))
  expect_true(checkNumeric(NA_real_))
  expect_true(checkNumeric(1:3, na.ok=FALSE, min.len=1L, max.len=3L))
  expect_false(checkNumeric(1:3, na.ok=FALSE, len=5))
  expect_true(checkNumeric(1:3, lower = 1L, upper = 3L))
  expect_false(checkNumeric(1:3, lower = 5))
})

test_that("assertNumeric", {
  expect_true(assertNumeric(1L))
  expect_error(assertNumeric(NA, "numeric"))
})
