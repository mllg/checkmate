context("checkChoice")

test_that("checkChoice", {
  expect_error(testChoice(character(0), letters), "length")
  expect_error(testChoice(NULL, letters), "atomic")

  expect_true(testChoice(1L, 1:10))
  expect_false(testChoice("ab", letters))
  expect_false(testChoice(NA_integer_, 1:10))
  expect_error(testChoice(1:2, 1:10), "length")

  expect_true(assertChoice(1L, 1:2))
  expect_error(assertChoice(-1, 1:2), "element of")
  expect_error(assertChoice(1L, list()), "atomic")
})
