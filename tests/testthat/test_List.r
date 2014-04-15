context("isList")

test_that("isList", {
  expect_true(isList(list()))
  expect_false(isList(NULL))
  expect_true(isList(list(1)))
  expect_false(isList(iris))

  x = as.list(iris)
  expect_true(isList(x, types = c("numeric", "factor")))
  expect_false(isList(x, types = c("integer", "factor")))
  expect_false(isList(x, types = c("numeric", "character")))
  expect_true(isList(list(NULL), "NULL"))

  expect_error(isList(list(), c("xxx")), "one of")
  expect_true(isList(list(), "numeric"))
})

test_that("assertList", {
  expect_true(assertList(list(TRUE)))
  expect_error(assertList(1), "list")

  x = as.list(iris)
  expect_true(assertList(x, types = c("numeric", "factor")))
  expect_error(assertList(x, types = "numeric"), "atomic types: numeric")
})
