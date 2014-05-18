context("check_data.frame")

test_that("check_data.frame", {
  expect_true(test(data.frame(), "data.frame"))
  expect_false(test(NULL, "data.frame"))
  expect_true(test(data.frame(1), "data.frame"))
  expect_true(test(iris, "data.frame"))
  expect_false(test(list(1), "data.frame"))

  x = iris
  expect_true(test(x, "data.frame", types = c("numeric", "factor")))
  expect_false(test(x, "data.frame", types = c("integer", "factor")))
  expect_false(test(x, "data.frame", types = c("numeric", "character")))
  expect_true(test(data.frame(), "data.frame", types = "NULL"))

  expect_true(test(data.frame(), "data.frame", types = "numeric"))

  expect_true(assert(data.frame(TRUE), "data.frame"))
  expect_error(assert(1, "data.frame"), "data.frame")

  expect_true(assert(x, "data.frame", types = c("numeric", "factor")))
  expect_error(assert(x, "data.frame", types = "numeric"), "types: numeric")
})
