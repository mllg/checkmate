context("check_choice")

test_that("check_choice", {
  expect_error(test(character(0), "choice", letters), "length")
  expect_error(test(NULL, "choice", letters), "atomic")

  expect_true(test(1L, "choice", 1:10))
  expect_false(test("ab", "choice", letters))
  expect_false(test(NA_integer_, "choice", 1:10))
  expect_error(test(1:2, "choice", 1:10), "length")

  expect_true(assert(1L, "choice", 1:2))
  expect_error(assert(-1, "choice", 1:2), "element of")
  expect_error(assert(1L, "choice", list()), "atomic")
})
