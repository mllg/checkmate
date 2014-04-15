context("isString")

test_that("isString", {
  expect_false(isString(character(0)))
  expect_false(isString(NULL))
  expect_true(isString(""))
  expect_true(isString("foo"))
  expect_false(isString(NA))
  expect_false(isString(NA_character_))
  expect_true(isString(NA_character_, na.ok=TRUE))
})

test_that("assertString", {
  expect_true(assertString("a"))
  expect_error(assertString(1, "string"))
  expect_error(assertString("a", pattern="b"), "pattern")
  expect_error(assertString("a", min.chars=10), "at least 10")
})
