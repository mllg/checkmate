context("checkList")

test_that("checkList", {
  expect_true(checkList(list()))
  expect_false(checkList(NULL))
  expect_true(checkList(list(1)))
  expect_false(checkList(iris))
})

test_that("assertList", {
  expect_true(assertList(list(TRUE)))
  expect_error(assertList(1), "list")
})
