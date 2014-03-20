context("checkConstant")

test_that("checkConstant", {
  expect_false(checkVariable(rep(NA, 2)))
  expect_false(checkVariable(1-0.9-0.1, 0))
  expect_false(checkVariable(c()))
  expect_false(checkVariable(rep(NA, 5)))
  expect_false(checkVariable(list(iris)))
  expect_false(checkVariable(list(iris, iris)))
  expect_false(checkVariable(c(1+1i, 1+1i)))

  expect_true(checkVariable(1:2))
  expect_true(checkVariable(c(1, NA)))
  expect_true(checkVariable(c(TRUE, NA)))
  expect_true(checkVariable(c(TRUE, NA)))
  expect_true(checkVariable(c(1+1i, 1+1.5i)))
  expect_true(checkVariable(list(1, 1, 1L)))
})
