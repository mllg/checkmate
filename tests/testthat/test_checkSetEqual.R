context("checkSetEqual")

test_that("checkSetEqual", {
  myobj = letters[3:1]
  expect_succ_all(SetEqual, myobj, letters[1:3])
  expect_fail_all(SetEqual, myobj, letters[1:3], ordered = TRUE)
  myobj = letters[1:2]
  expect_fail_all(String, myobj, letters[1:3])

  expect_true(testSetEqual(character(0), character(0)))
  expect_true(testSetEqual(character(0), character(0), ordered = TRUE))
  expect_false(testSetEqual(character(0), letters))
  expect_false(testSetEqual(letters, character(0)))
  expect_false(testSetEqual(NULL, letters))
  expect_false(testSetEqual(NULL, letters, ordered = TRUE))
  expect_false(testSetEqual(factor("a"), letters))
  expect_true(testSetEqual(factor(letters), factor(letters)))
  expect_false(testSetEqual(letters, factor(letters)))

  expect_true(testSetEqual(1L, 1L))
  expect_true(testSetEqual(1, 1L))
  expect_true(testSetEqual(3:4, 3:4))
  expect_true(testSetEqual(NA_integer_, NA_integer_))

  expect_true(testSetEqual(1:2, 1:2, ordered = TRUE))
  expect_false(testSetEqual(1:2, 2:1, ordered = TRUE))
  expect_true(testSetEqual(NA, NA, ordered = TRUE))
  expect_false(testSetEqual(NA_integer_, 1L, ordered = TRUE))
  expect_false(testSetEqual(1L, NA_integer_, ordered = TRUE))
  expect_false(testSetEqual(c(NA_integer_, 2L), 1:2, ordered = TRUE))
  expect_true(testSetEqual(c(NA_integer_, 2L), c(NA_real_, 2), ordered = TRUE))

  expect_error(assertSetEqual(1, 1:2), "equal to")
  expect_error(assertSetEqual(1L, list()), "atomic")
})


test_that("checkSetEqual / fastmatch", {
  skip_if_not_installed("fastmatch")
  x = letters[5:1]
  y = letters[1:5]

  res = testSetEqual(x, y)
  expect_true(res)
  expect_null(attr(y, ".match.hash"))

  res = testSetEqual(x, y, fmatch = TRUE)
  expect_true(res)
  expect_class(attr(y, ".match.hash"), "match.hash")
})
