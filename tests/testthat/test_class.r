context("checkClass")

test_that("checkClass", {
  expect_true(testClass(NULL, "NULL"))
  expect_true(testClass(1, "numeric"))
  expect_true(testClass(1L, "integer"))
  expect_false(testClass(1, "integer"))

  foo = 1
  class(foo) = c("a", "b")
  expect_true(testClass(foo, "a"))
  expect_true(testClass(foo, "b"))
  expect_false(testClass(foo, "c"))
  expect_true(testClass(foo, "a", ordered=TRUE))
  expect_false(testClass(foo, "b", ordered=TRUE))
  expect_true(testClass(foo, c("a", "b"), ordered=TRUE))
  expect_false(testClass(foo, c("b", "a"), ordered=TRUE))

  foo = 1
  class(foo) = c("a", "b")
  expect_true(assertClass(foo, "a"))
  expect_error(assertClass(foo, "c"), "class 'c'")
  expect_error(assertClass(foo, "b", ordered=TRUE), "position 1")
})
