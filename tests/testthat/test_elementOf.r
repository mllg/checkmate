context("check_elementOf")

test_that("check_elementOf", {
  expect_error(test(character(0), "elementOf", letters), "length")
  expect_error(test(NULL, "elementOf", letters), "atomic")

  expect_true(test(1L, "elementOf", 1:10))
  expect_false(test("ab", "elementOf", letters))
  expect_false(test(NA_integer_, "elementOf", 1:10))
  expect_error(test(1:2, "elementOf", 1:10), "length")

  expect_true(assert(1L, "elementOf", 1:2))
  expect_error(assert(-1, "elementOf", 1:2), "element of set")
  expect_error(assert(1L, "elementOf", list()), "atomic")
})
