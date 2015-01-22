context("which.first")

test_that("which.first", {
  x = c(NA, FALSE, TRUE, FALSE, TRUE, FALSE, NA)
  expect_equal(wf(x), 3)
  expect_equal(wl(x), 5)
  expect_equal(wf(logical(0)), integer(0))
  expect_equal(wl(logical(0)), integer(0))

  expect_error(wf(42), "logical")
  expect_error(wl(42), "logical")
})
