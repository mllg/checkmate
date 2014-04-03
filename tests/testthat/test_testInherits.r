context("checkInherits")

test_that("checkInherits", {

  expect_true(checkInherits(1, "numeric"))
  expect_true(checkInherits(1L, "integer"))
  expect_false(checkInherits(1, "integer"))

  foo = 1
  class(foo) = c("a", "b")
  expect_true(checkInherits(foo, "a"))
  expect_true(checkInherits(foo, "b"))
  expect_false(checkInherits(foo, "c"))
})

test_that("assertInherits", {
  expect_true(assertInherits(1L, "integer"))
  expect_error(assertInherits(1, "integer"), "class 'integer'")
})
