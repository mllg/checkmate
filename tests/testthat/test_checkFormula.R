context("checkFormula")

test_that("checkFormula", {
  f = ~ x
  expect_succ_all(Formula, f)
  expect_fail_all(Formula, 1)

  f = y ~ x + z
  expect_true(checkFormula(f))

  f = y ~ x:z + I(a)
  expect_true(checkFormula(f))

  expect_true(checkFormula(NULL, null.ok = TRUE))
  expect_error(assertFormula(1, "formula"))
})
