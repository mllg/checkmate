context("check_list")

test_that("check_list", {
  expect_true(test(list(), "list"))
  expect_false(test(NULL, "list"))
  expect_true(test(list(1), "list"))
  expect_false(test(iris, "list"))

  x = as.list(iris)
  expect_true(test(x, "list", types = c("numeric", "factor")))
  expect_false(test(x, "list", types = c("integer", "factor")))
  expect_false(test(x, "list", types = c("numeric", "character")))
  expect_true(test(list(NULL), "list", types = "NULL"))

  expect_error(test(list(), "list", types = c("xxx")), "one of")
  expect_true(test(list(), "list", types = "numeric"))


  expect_true(assert(list(TRUE), "list"))
  expect_error(assert(1, "list"), "list")

  expect_true(assert(x, "list", types = c("numeric", "factor")))
  expect_error(assert(x, "list", types = "numeric"), "atomic types: numeric")
})
