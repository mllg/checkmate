context("isConstant")

test_that("isConstant", {
  expect_true(isConstant(rep(NA, 2)))
  expect_true(isConstant(1-0.9-0.1, 0))
  expect_true(isConstant(c()))
  expect_true(isConstant(rep(NA, 5)))
  expect_true(isConstant(list(iris)))
  expect_true(isConstant(list(iris, iris)))
  expect_true(isConstant(c(1+1i, 1+1i)))

  expect_false(isConstant(1:2))
  expect_false(isConstant(c(1, NA)))
  expect_false(isConstant(c(TRUE, NA)))
  expect_false(isConstant(c(TRUE, NA)))
  expect_false(isConstant(c(1+1i, 1+1.5i)))
  expect_false(isConstant(list(1, 1, 1L)))
})
