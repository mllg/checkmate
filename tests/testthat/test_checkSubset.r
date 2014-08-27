context("checkSubset")

test_that("checkSubset", {
  myobj = letters[1:3]
  expect_succ(Subset, myobj, letters)
  myobj = 1:2
  expect_fail(Subset, myobj, letters)

  expect_false(testSubset(character(0), letters, empty.ok = FALSE))
  expect_true(testSubset(character(0), letters, empty.ok = TRUE))
  expect_false(testSubset(NULL, letters, empty.ok = FALSE))
  expect_true(testSubset(NULL, letters, empty.ok = TRUE))

  expect_true(testSubset(1L, 1:10))
  expect_true(testSubset(3:4, 1:10))
  expect_false(testSubset("ab", letters))
  expect_false(testSubset(NA_integer_, 1:10))

  expect_error(assertSubset(-1, 1:2), "subset of")
  expect_error(assertSubset(1L, list()), "atomic")
})
