context("checkScalarNA")

test_that("checkScalarNA", {
  expect_true(testScalarNA(NA))
  expect_true(testScalarNA(NA_real_))
  expect_false(testScalarNA(1))
  expect_false(testScalarNA(rep(NA_character_, 2)))

  expect_error(assertScalarNA(integer(0)), "missing value")
})
