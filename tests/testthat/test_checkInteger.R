context("checkInteger")

test_that("checkInteger", {
  myobj = 1L
  expect_succ_all(Integer, myobj)
  myobj = 1
  expect_fail_all(Integer, myobj)

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
  expect_false(testInteger(1:3, upper = 1))

  expect_error(assertInteger(1), "integer")
})

test_that("bounds of vectors with only missings are not checked", {
  expect_true(checkInteger(NA, lower = 1))
  expect_true(checkInteger(NA_character_, upper = 10))
  expect_fail_all(Integer, 0L, lower = 1L)
  expect_fail_all(Integer, 100L, upper = 10L)
})
