context("generated messages")

test_that("No extra strings attached to generated error messages", {
  foo = function(XX) assertFlag(XX)
  x = try(foo(iris), silent = TRUE)
  expect_error(foo(iris), "^Assertion on 'XX'")
  expect_error(foo(iris), "not 'data.frame'\\.$")
})
