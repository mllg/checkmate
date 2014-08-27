context("checkSetEqual")

test_that("checkSetEqual", {
  myobj = letters[1:3]
  expect_succ(SetEqual, myobj, letters[1:3])
  myobj = letters[1:2]
  expect_fail(String, myobj, letters[1:3])

  expect_true(testSetEqual(character(0), character(0)))
  expect_true(testSetEqual(character(0), character(0), ordered = TRUE))
  expect_false(testSetEqual(character(0), letters))
  expect_false(testSetEqual(letters, character(0)))
  expect_false(testSetEqual(NULL, letters))
  expect_false(testSetEqual(NULL, letters, ordered = TRUE))

  expect_true(testSetEqual(1L, 1L))
  expect_true(testSetEqual(3:4, 3:4))
  expect_true(testSetEqual(NA_integer_, NA_integer_))
  expect_true(testSetEqual(NA_integer_, NA))

  expect_true(testSetEqual(1:2, 1:2, ordered = TRUE))
  expect_false(testSetEqual(1:2, 2:1, ordered = TRUE))
  expect_true(testSetEqual(NA, NA, ordered = TRUE))
  expect_false(testSetEqual(NA_integer_, 1L, ordered = TRUE))
  expect_false(testSetEqual(1L, NA_integer_, ordered = TRUE))
  expect_true(testSetEqual(NA_integer_, NA, ordered = TRUE))
  expect_false(testSetEqual(c(NA_integer_, 2L), 1:2, ordered = TRUE))
  expect_true(testSetEqual(c(NA_integer_, 2L), c(NA_real_, 2), ordered = TRUE))

  expect_error(assertSetEqual(1, 1:2), "equal to")
  expect_error(assertSetEqual(1L, list()), "atomic")
})
