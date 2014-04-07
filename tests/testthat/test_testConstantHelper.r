context("isConstant")

test_that("isConstant", {
  expect_false(isVariableVector(rep(NA, 2)))
  expect_false(isVariableVector(1-0.9-0.1, 0))
  expect_false(isVariableVector(c()))
  expect_false(isVariableVector(rep(NA, 5)))
  expect_false(isVariableVector(list(iris)))
  expect_false(isVariableVector(list(iris, iris)))
  expect_false(isVariableVector(c(1+1i, 1+1i)))

  expect_true(isVariableVector(1:2))
  expect_true(isVariableVector(c(1, NA)))
  expect_true(isVariableVector(c(TRUE, NA)))
  expect_true(isVariableVector(c(TRUE, NA)))
  expect_true(isVariableVector(c(1+1i, 1+1.5i)))
  expect_true(isVariableVector(list(1, 1, 1L)))
})
