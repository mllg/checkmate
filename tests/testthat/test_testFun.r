context("checkFun")


myfun = function(x, y, ...) x + y

test_that("checkFun", {
  expect_false(checkFun(NULL))
  expect_true(checkFun(identity))
  expect_true(checkFun(myfun))
  # FIXME this does not work ... is this a testthat issue?
  # expect_true(checkFun("myfun"))
  expect_false(checkFun(fff))
  expect_false(checkFun("fff"))

  expect_true(checkFun(myfun, args = "x"))
  expect_true(checkFun(myfun, args = "..."))
  expect_true(checkFun(myfun, args = "x", ordered=TRUE))
  expect_true(checkFun(myfun, args = "y"))
  expect_true(checkFun(myfun, args = c("x", "y")))
  expect_true(checkFun(myfun, args = c("x", "y", "...")))
  expect_true(checkFun(myfun, args = c("y", "x")))
  expect_true(checkFun(myfun, args = c("x", "y"), ordered=TRUE))
  expect_false(checkFun(myfun, args = "z"))
  expect_false(checkFun(myfun, args = c("y"), ordered=TRUE))
  expect_false(checkFun(myfun, args = c("y", "x"), ordered=TRUE))
})

test_that("assertFun", {
  expect_true(assertFun(myfun))
  expect_error(assertFun(fff), "not found")
  expect_error(assertFun(myfun, "z"), "formal arguments")
  expect_error(assertFun(myfun, "y", ordered=TRUE), "first formal arguments")
})
