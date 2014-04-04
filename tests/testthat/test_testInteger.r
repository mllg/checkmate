context("checkInteger")

test_that("checkInteger", {
  expect_true(checkInteger(integer(0)))
  expect_false(checkInteger(NULL))
  expect_false(checkInteger(TRUE))
  expect_false(checkInteger(NA))
  expect_true(checkInteger(1L))
  expect_true(checkInteger(1:3, na.ok=FALSE, min.len=1L, max.len=3L))
  expect_false(checkInteger(1:3, na.ok=FALSE, len=5))
  expect_true(checkInteger(1:3, lower = 1L, upper = 3L))
  expect_false(checkInteger(1:3, lower = 5))
})

test_that("assertInteger", {
  expect_true(assertInteger(1L))
  expect_error(assertInteger(NA, "integer"))
})
