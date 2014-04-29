context("check_integer")

test_that("check_integer", {
  expect_true(test(integer(0), "integer"))
  expect_false(test(NULL, "integer"))
  expect_false(test(TRUE, "integer"))
  expect_true(test(NA, "integer"))
  expect_false(test(NA, "integer", any.missing = FALSE))
  expect_false(test(NA, "integer", all.missing = FALSE))
  expect_true(test(1L, "integer"))
  expect_true(test(1:3, "integer", any.missing=FALSE, min.len=1L, max.len=3L))
  expect_false(test(1:3, "integer", any.missing=FALSE, len=5))
  expect_true(test(1:3, "integer", lower = 1L, upper = 3L))
  expect_false(test(1:3, "integer", lower = 5))
})

test_that("assertInteger", {
  expect_true(assert(1L, "integer"))
  expect_error(assert(1, "integer"), "integer")
})
