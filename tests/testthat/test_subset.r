context("check_subset")

test_that("check_subset", {
  expect_true(test(character(0), "subset", letters))
  expect_true(test(NULL, "subset", letters))

  expect_true(test(1L, "subset", 1:10))
  expect_true(test(3:4, "subset", 1:10))
  expect_false(test("ab", "subset", letters))
  expect_false(test(NA_integer_, "subset", 1:10))

  expect_true(assert(1L, "subset", 1:2))
  expect_error(assert(-1, "subset", 1:2), "All elements of")
  expect_error(assert(1L, "subset", list()), "atomic")
})
