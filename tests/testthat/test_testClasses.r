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
})

test_that("assertInherits", {
  expect_true(assertClasses(1L, "integer"))
  expect_error(assertClasses(1, "integer"), "class 'integer'")
})
