context("checkInconstant")

test_that("checkInconstant", {
  expect_false(testInconstant(rep(NA, 2)))
  expect_false(testInconstant(c(1-0.9-0.1, 0)))
  expect_false(testInconstant(c()))
  expect_false(testInconstant(rep(NA, 5)))
  expect_false(testInconstant(list(iris)))
  expect_false(testInconstant(list(iris, iris)))
  expect_false(testInconstant(c(1+1i, 1+1i)))

  expect_true(testInconstant(1:2))
  expect_true(testInconstant(c(1, NA)))
  expect_true(testInconstant(c(TRUE, NA)))
  expect_true(testInconstant(c(TRUE, NA)))
  expect_true(testInconstant(c(1+1i, 1+1.5i)))
  expect_true(testInconstant(list(1, 1, 1L)))

  expect_true(assertInconstant(1:2))
  expect_true(assertConstant(1))
  expect_error(assertInconstant(1), "inconstant")
  expect_error(assertConstant(1:2), "constant")
})
