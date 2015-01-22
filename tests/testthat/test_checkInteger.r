context("checkInteger")

test_that("checkInteger", {
  myobj = 1L
  expect_succ(Integer, myobj)
  myobj = 1
  expect_fail(Integer, myobj)

  expect_true(testInteger(integer(0)))
  expect_false(testInteger(NULL))
  expect_false(testInteger(TRUE))
  expect_true(testInteger(NA))
  expect_false(testInteger(NA, any.missing = FALSE))
  expect_false(testInteger(NA, all.missing = FALSE))
  expect_true(testInteger(1L))
  expect_true(testInteger(1:3, any.missing = FALSE, min.len = 1L, max.len = 3L))
  expect_false(testInteger(1:3, any.missing = FALSE, len = 5))
  expect_true(testInteger(1:3, lower = 1L, upper = 3L))
  expect_false(testInteger(1:3, lower = 5))

  expect_error(assertInteger(1), "integer")
})
