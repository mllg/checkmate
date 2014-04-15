context("isNumeric")

test_that("isNumeric", {
  expect_true(isNumeric(integer(0)))
  expect_false(isNumeric(NULL))
  expect_false(isNumeric(TRUE))
  expect_false(isNumeric(NA))
  expect_true(isNumeric(1L))
  expect_true(isNumeric(1))
  expect_true(isNumeric(Inf))
  expect_true(isNumeric(NA_real_))
  expect_true(isNumeric(1:3, na.ok=FALSE, min.len=1L, max.len=3L))
  expect_false(isNumeric(1:3, na.ok=FALSE, len=5))
  expect_true(isNumeric(1:3, lower = 1L, upper = 3L))
  expect_false(isNumeric(1:3, lower = 5))
})

test_that("assertNumeric", {
  expect_true(assertNumeric(1L))
  expect_error(assertNumeric(NA, "numeric"))
})
