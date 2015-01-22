context("which.first")

test_that("which.first", {
  x = c(NA, FALSE, TRUE, FALSE, TRUE, FALSE, NA)
  expect_equal(which.first(x), 3)
  expect_equal(which.last(x), 5)
  expect_equal(which.first(logical(0)), integer(0))
  expect_equal(which.last(logical(0)), integer(0))

  expect_error(which.first(42), "logical")
  expect_error(which.last(42), "logical")
})
