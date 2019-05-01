context("checkSubset")

test_that("checkSubset", {
  myobj = letters[1:3]
  expect_succ_all(Subset, myobj, letters)
  myobj = 1:2
  expect_fail_all(Subset, myobj, letters)

  expect_false(testSubset(character(0), letters, empty.ok = FALSE))
  expect_true(testSubset(character(0), letters, empty.ok = TRUE))
  expect_false(testSubset(NULL, letters, empty.ok = FALSE))
  expect_true(testSubset(character(0), letters, empty.ok = TRUE))
  expect_false(testSubset(NULL, letters, empty.ok = FALSE))
  expect_true(testSubset(NULL, letters, empty.ok = TRUE))
  expect_false(testSubset(factor("a"), letters))
  expect_true(testSubset(1., 1:2))
  expect_true(testSubset(factor("a"), factor(letters)))

  expect_true(testSubset(1L, 1:10))
  expect_true(testSubset(3:4, 1:10))
  expect_false(testSubset("ab", letters))
  expect_false(testSubset(NA_integer_, 1:10))

  expect_error(assertSubset(-1, 1:2), "subset of")
  expect_error(assertSubset(1L, list()), "atomic")

  # issue #109
  expect_true(testSubset(character(0), character(0)))
  expect_true(testSubset(integer(0), character(0)))
  expect_error(assertSubset(1, integer(0)), "empty set")
})


test_that("checkSubset / fastmatch", {
  skip_if_not_installed("fastmatch")
  x = "c"
  y = letters[1:5]

  res = testSubset(x, y)
  expect_true(res)
  expect_null(attr(y, ".match.hash"))

  res = testSubset(x, y, fmatch = TRUE)
  expect_true(res)
  expect_class(attr(y, ".match.hash"), "match.hash")
})

test_that("checkSubset / NAs (#158)", {
  expect_true(test_subset(NA_character_, NA))
  expect_true(test_subset(NA, NA_character_))
})
