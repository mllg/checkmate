context("checkList")

test_that("checkList", {
  myobj = list(1, 2, 3)
  expect_succ(List, myobj)
  myobj = TRUE
  expect_fail(List, myobj)

  expect_true(testList(list()))
  expect_false(testList(NULL))
  expect_true(testList(list(1)))
  expect_false(testList(iris))

  x = as.list(iris)
  expect_true(testList(x, types = c("numeric", "factor")))
  expect_false(testList(x, types = c("integer", "factor")))
  expect_false(testList(x, types = c("numeric", "character")))
  expect_true(testList(x, types = c("vector", "factor")))
  expect_true(testList(list(NULL), types = "NULL"))
  expect_true(testList(list(), types = "numeric"))
  expect_false(testList(list(TRUE), types = "numeric"))
  expect_error(assertList(x, types = "numeric"), "types: numeric")
  expect_error(assertList(x, len = 33), "Must have length 33")

  expect_true(testList(list(), names = "named"))

  x = 1:3
  class(x) = "foo"
  x = list(x, 1:3)
  expect_true(testList(x, types = c("foo", "integerish")))
  expect_error(assertList(1), "list")
})
