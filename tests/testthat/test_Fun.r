context("isFun")


myfun = function(x, y, ...) x + y

test_that("isFun", {
  expect_false(isFun(NULL))
  expect_true(isFun(identity))
  expect_true(isFun(myfun))
  # FIXME this does not work ... is this a testthat issue?
  # expect_true(isFun("myfun"))
  expect_false(isFun(fff))
  expect_false(isFun("fff"))

  expect_true(isFun(myfun, args = "x"))
  expect_true(isFun(myfun, args = "..."))
  expect_true(isFun(myfun, args = "x", ordered=TRUE))
  expect_true(isFun(myfun, args = "y"))
  expect_true(isFun(myfun, args = c("x", "y")))
  expect_true(isFun(myfun, args = c("x", "y", "...")))
  expect_true(isFun(myfun, args = c("y", "x")))
  expect_true(isFun(myfun, args = c("x", "y"), ordered=TRUE))
  expect_false(isFun(myfun, args = "z"))
  expect_false(isFun(myfun, args = c("y"), ordered=TRUE))
  expect_false(isFun(myfun, args = c("y", "x"), ordered=TRUE))
})

test_that("assertFun", {
  expect_true(assertFun(myfun))
  expect_error(assertFun(fff), "not found")
  expect_error(assertFun(myfun, "z"), "formal arguments")
  expect_error(assertFun(myfun, "y", ordered=TRUE), "first formal arguments")
})
