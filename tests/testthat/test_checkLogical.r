context("checkLogical")

test_that("checkLogical", {
  expect_true(testLogical(logical(0)))
  expect_false(testLogical(NULL))
  expect_true(testLogical(TRUE))
  expect_true(testLogical(NA))
  expect_true(testLogical(NA_real_))
  expect_true(testLogical(FALSE))
  expect_false(testLogical(NA, any.missing=FALSE))
  expect_false(testLogical(NA, all.missing=FALSE))
  expect_false(testLogical(iris))
  expect_true(testLogical(c(TRUE, FALSE), min.len = 2))

  expect_true(assertLogical(TRUE))
  expect_error(assertLogical(1))
})
