context("isClasses")

test_that("isClasses", {
  expect_true(isClasses(NULL, "NULL"))
  expect_true(isClasses(1, "numeric"))
  expect_true(isClasses(1L, "integer"))
  expect_false(isClasses(1, "integer"))

  foo = 1
  class(foo) = c("a", "b")
  expect_true(isClasses(foo, "a"))
  expect_true(isClasses(foo, "b"))
  expect_false(isClasses(foo, "c"))
  expect_true(isClasses(foo, "a", ordered=TRUE))
  expect_false(isClasses(foo, "b", ordered=TRUE))
  expect_true(isClasses(foo, c("a", "b"), ordered=TRUE))
  expect_false(isClasses(foo, c("b", "a"), ordered=TRUE))
})

test_that("assertInherits", {
  foo = 1
  class(foo) = c("a", "b")
  expect_true(assertClasses(foo, "a"))
  expect_error(assertClasses(foo, "c"), "class 'c'")
  expect_error(assertClasses(foo, "b", ordered=TRUE), "position 1")
})
