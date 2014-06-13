context("assert")

test_that("assert", {
  x = NULL
  expect_true(assert(checkNull(x), checkDataFrame(x)))
  x = iris
  expect_true(assert(checkNull(x), checkDataFrame(x)))
  x = 1
  expect_error(assert(checkNull(x), checkDataFrame(x)), "One of")
})
