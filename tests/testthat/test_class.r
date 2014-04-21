context("check_class")

test_that("check_class", {
  expect_true(test(NULL, "class", "NULL"))
  expect_true(test(1, "class", "numeric"))
  expect_true(test(1L, "class", "integer"))
  expect_false(test(1, "class", "integer"))

  foo = 1
  class(foo) = c("a", "b")
  expect_true(test(foo, "class", "a"))
  expect_true(test(foo, "class", "b"))
  expect_false(test(foo, "class", "c"))
  expect_true(test(foo, "class", "a", ordered=TRUE))
  expect_false(test(foo, "class", "b", ordered=TRUE))
  expect_true(test(foo, "class", c("a", "b"), ordered=TRUE))
  expect_false(test(foo, "class", c("b", "a"), ordered=TRUE))


  foo = 1
  class(foo) = c("a", "b")
  expect_true(assert(foo, "class", "a"))
  expect_error(assert(foo, "class", "c"), "class 'c'")
  expect_error(assert(foo, "class", "b", ordered=TRUE), "position 1")
})
