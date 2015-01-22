context("checkClass")

test_that("checkClass", {
  myobj = 1
  expect_succ(Class, myobj, "numeric")
  expect_fail(Class, myobj, "integer")

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
  expect_error(assertClass(foo, "c"), "Must have class 'c', but has classes 'a','b'")
  expect_error(assertClass(foo, "b", ordered=TRUE), "Must have class 'b' in position 1, but has classes 'a','b'")

  foo = 1
  class(foo) = "a"
  expect_error(assertClass(foo, "c"), "Must have class 'c', but has class 'a'")
})
