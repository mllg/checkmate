context("checkDisjunct")

test_that("checkDisjunct", {
  myobj = 1:3
  expect_succ_all(Disjunct, myobj, letters)
  myobj = "b"
  expect_fail_all(Disjunct, myobj, letters)

  expect_true(testDisjunct(character(0), letters))
  expect_true(testDisjunct(letters, character(0)))
  expect_true(testDisjunct(character(0L), character(0)))

  expect_false(testDisjunct(factor("a"), letters))
  expect_false(testDisjunct(1., 1:2))
  expect_false(testDisjunct(factor("a"), factor(letters)))

  expect_true(testDisjunct(NA_integer_, 1:10))
  expect_false(testDisjunct(NA_integer_, c(1:10, NA_integer_)))

  expect_error(assertSubset(1L, list()), "atomic")

  expect_true(testDisjunct(integer(0), character(0)))
  expect_error(assert_disjunct("a", "a"), "disjunct from")
})


test_that("checkSubset / fastmatch", {
  skip_if_not_installed("fastmatch")
  x = "c"
  y = letters[1:5]

  res = testDisjunct(x, y)
  expect_false(res)
  expect_null(attr(y, ".match.hash"))

  res = testDisjunct(x, y, fmatch = TRUE)
  expect_false(res)
  expect_class(attr(y, ".match.hash"), "match.hash")
})
