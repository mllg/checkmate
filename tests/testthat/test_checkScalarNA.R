context("checkScalarNA")

test_that("checkScalarNA", {
  expect_succ_all("ScalarNA", NA)
  expect_fail_all("ScalarNA", 1)
  expect_true(testScalarNA(NA_real_))
  expect_false(testScalarNA(1))
  expect_false(testScalarNA(rep(NA_character_, 2)))
  expect_expectation_successful(expect_scalar_na(NA), label = NULL)

  expect_error(assertScalarNA(integer(0)), "missing value")
})

test_that("checkScalarNA on data.frame/data.table (#245)", {
  df = data.frame(x = 1:2)
  expect_false(testScalarNA(df))
})
