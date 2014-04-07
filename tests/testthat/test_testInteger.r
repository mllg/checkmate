context("isInteger")

test_that("isInteger", {
  expect_true(isInteger(integer(0)))
  expect_false(isInteger(NULL))
  expect_false(isInteger(TRUE))
  expect_false(isInteger(NA))
  expect_true(isInteger(1L))
  expect_true(isInteger(1:3, na.ok=FALSE, min.len=1L, max.len=3L))
  expect_false(isInteger(1:3, na.ok=FALSE, len=5))
  expect_true(isInteger(1:3, lower = 1L, upper = 3L))
  expect_false(isInteger(1:3, lower = 5))
})

test_that("assertInteger", {
  expect_true(assertInteger(1L))
  expect_error(assertInteger(NA, "integer"))
})
