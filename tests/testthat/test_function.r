context("check_function")


myfun = function(x, y, ...) x + y

test_that("check_function", {
  expect_false(test(NULL, "function"))
  expect_true(test(identity, "function"))
  expect_true(test(myfun, "function"))
  # FIXME this does not work ... is this a testthat issue?
  # expect_true(test("myfun"))
  expect_false(test(fff, "function"))
  expect_false(test("fff", "function"))

  expect_true(test(myfun, "function", args = "x"))
  expect_true(test(myfun, "function", args = "..."))
  expect_true(test(myfun, "function", args = "x", ordered=TRUE))
  expect_true(test(myfun, "function", args = "y"))
  expect_true(test(myfun, "function", args = c("x", "y")))
  expect_true(test(myfun, "function", args = c("x", "y", "...")))
  expect_true(test(myfun, "function", args = c("y", "x")))
  expect_true(test(myfun, "function", args = c("x", "y"), ordered=TRUE))
  expect_false(test(myfun, "function", args = "z"))
  expect_false(test(myfun, "function", args = c("y"), ordered=TRUE))
  expect_false(test(myfun, "function", args = c("y", "x"), ordered=TRUE))


  expect_true(assert(myfun, "function"))
  expect_error(assert(fff, "function"), "not found")
  expect_error(assert(myfun, "function", "z"), "formal arguments")
  expect_error(assert(myfun, "function", "y", ordered=TRUE), "first formal arguments")
})
