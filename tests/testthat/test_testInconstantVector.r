context("isInconstant")

test_that("isInconstant", {
  expect_false(isInconstantVector(rep(NA, 2)))
  expect_false(isInconstantVector(1-0.9-0.1, 0))
  expect_false(isInconstantVector(c()))
  expect_false(isInconstantVector(rep(NA, 5)))
  expect_false(isInconstantVector(list(iris)))
  expect_false(isInconstantVector(list(iris, iris)))
  expect_false(isInconstantVector(c(1+1i, 1+1i)))

  expect_true(isInconstantVector(1:2))
  expect_true(isInconstantVector(c(1, NA)))
  expect_true(isInconstantVector(c(TRUE, NA)))
  expect_true(isInconstantVector(c(TRUE, NA)))
  expect_true(isInconstantVector(c(1+1i, 1+1.5i)))
  expect_true(isInconstantVector(list(1, 1, 1L)))
})

test_that("assertInconstant", {
  expect_true(assertConstantVector(1))
  expect_error(assertConstantVector(1:2), "constant")
  expect_true(assertInconstantVector(1:2))
  expect_error(assertInconstantVector(1), "inconstant")
})
