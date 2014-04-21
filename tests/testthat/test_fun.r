context("check_fun")


myfun = function(x, y, ...) x + y

test_that("check_fun", {
  expect_false(test(NULL, "fun"))
  expect_true(test(identity, "fun"))
  expect_true(test(myfun, "fun"))
  # FIXME this does not work ... is this a testthat issue?
  # expect_true(test("myfun"))
  expect_false(test(fff, "fun"))
  expect_false(test("fff", "fun"))

  expect_true(test(myfun, "fun", args = "x"))
  expect_true(test(myfun, "fun", args = "..."))
  expect_true(test(myfun, "fun", args = "x", ordered=TRUE))
  expect_true(test(myfun, "fun", args = "y"))
  expect_true(test(myfun, "fun", args = c("x", "y")))
  expect_true(test(myfun, "fun", args = c("x", "y", "...")))
  expect_true(test(myfun, "fun", args = c("y", "x")))
  expect_true(test(myfun, "fun", args = c("x", "y"), ordered=TRUE))
  expect_false(test(myfun, "fun", args = "z"))
  expect_false(test(myfun, "fun", args = c("y"), ordered=TRUE))
  expect_false(test(myfun, "fun", args = c("y", "x"), ordered=TRUE))


  expect_true(assert(myfun, "fun"))
  expect_error(assert(fff, "fun"), "not found")
  expect_error(assert(myfun, "fun", "z"), "formal arguments")
  expect_error(assert(myfun, "fun", "y", ordered=TRUE), "first formal arguments")
})
