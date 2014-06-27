context("checkChoice")

test_that("checkChoice", {
  expect_false(testChoice(character(0), letters))
  expect_false(testChoice(NULL, letters))
  expect_false(testChoice(1, NULL))
  expect_error(testChoice(list(1), as.list(iris)), "atomic")

  expect_true(testChoice(1L, 1:10))
  expect_false(testChoice("ab", letters))
  expect_false(testChoice(NA_integer_, 1:10))
  expect_false(testChoice(1:2, 1:10))

  expect_true(assertChoice(1L, 1:2))
  expect_error(assertChoice(-1, 1:2), "element of")
  expect_error(assertChoice(1L, list()), "atomic")
})
