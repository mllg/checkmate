context("checkSubset")

test_that("checkSubset", {
  expect_true(testSubset(character(0), letters))
  expect_true(testSubset(NULL, letters))

  expect_true(testSubset(1L, 1:10))
  expect_true(testSubset(3:4, 1:10))
  expect_false(testSubset("ab", letters))
  expect_false(testSubset(NA_integer_, 1:10))

  expect_true(assertSubset(1L, 1:2))
  expect_error(assertSubset(-1, 1:2), "subset of")
  expect_error(assertSubset(1L, list()), "atomic")
})
