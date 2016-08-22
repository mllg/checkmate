context("generated messages")

test_that("No extra strings attached to generated error messages", {
  foo = function(XX) assertFlag(XX)
  expect_error(foo(iris), "^Assertion on 'XX'")
  expect_error(foo(iris), "not 'data.frame'\\.$")
})
