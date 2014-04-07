context("isList")

test_that("isList", {
  expect_true(isList(list()))
  expect_false(isList(NULL))
  expect_true(isList(list(1)))
  expect_false(isList(iris))
})

test_that("assertList", {
  expect_true(assertList(list(TRUE)))
  expect_error(assertList(1), "list")
})
