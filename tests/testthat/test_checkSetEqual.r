context("checkSetEqual")

test_that("checkSetEqual", {
  expect_true(testSetEqual(character(0), character(0)))
  expect_false(testSetEqual(character(0), letters))
  expect_false(testSetEqual(letters, character(0)))
  expect_false(testSetEqual(NULL, letters))
  expect_false(testSetEqual(NULL, letters))

  expect_true(testSetEqual(1L, 1L))
  expect_true(testSetEqual(3:4, 3:4))
  expect_true(testSetEqual(NA_integer_, NA_integer_))
  expect_true(testSetEqual(NA_integer_, NA))

  expect_true(assertSetEqual(1L, 1))
  expect_error(assertSetEqual(1, 1:2), "equal to")
  expect_error(assertSetEqual(1L, list()), "atomic")
})
