context("checkConstant")

test_that("checkConstant", {
  expect_true(checkConstant(rep(NA, 2)))
  expect_true(checkConstant(1-0.9-0.1, 0))
  expect_true(checkConstant(c()))
  expect_true(checkConstant(rep(NA, 5)))
  expect_true(checkConstant(list(iris)))
  expect_true(checkConstant(list(iris, iris)))
  expect_true(checkConstant(c(1+1i, 1+1i)))

  expect_false(checkConstant(1:2))
  expect_false(checkConstant(c(1, NA)))
  expect_false(checkConstant(c(TRUE, NA)))
  expect_false(checkConstant(c(TRUE, NA)))
  expect_false(checkConstant(c(1+1i, 1+1.5i)))
  expect_false(checkConstant(list(1, 1, 1L)))
})
