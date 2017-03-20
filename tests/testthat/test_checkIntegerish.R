context("checkIntegerish")

test_that("checkIntegerish", {
  myobj = 1
  expect_succ_all(Integerish, myobj)
  myobj = 3.3
  expect_fail_all(Integerish, myobj)

  x = 1 - 0.9 -.1

  expect_true(testIntegerish(integer(0)))
  expect_false(testIntegerish(NULL))
  expect_false(testIntegerish(TRUE))
  expect_false(testIntegerish(FALSE))
  expect_true(testIntegerish(1L))
  expect_true(testIntegerish(c(-1, 0, 1)))
  expect_true(testIntegerish(1.))
  expect_true(testIntegerish(x))

  expect_true(testIntegerish(NA))
  expect_true(testIntegerish(NaN))
  expect_true(testIntegerish(c(1L, NA)))
  expect_true(testIntegerish(c(1, NA)))
  expect_true(testIntegerish(c(1, NaN)))

  expect_false(testIntegerish(1:2 + 0.0001))
  expect_false(testIntegerish(-Inf))
  expect_false(testIntegerish(Inf))

  expect_true(testIntegerish(3+0i))
  expect_false(testIntegerish(3-1i))
  expect_true(testIntegerish(as.complex(NA)))
  expect_false(testIntegerish(3+2i))
  expect_false(testIntegerish(list()))

  max = as.double(.Machine$integer.max)
  min = as.double(-.Machine$integer.max)
  expect_true(testIntegerish(min))
  expect_true(testIntegerish(max))
  expect_false(testIntegerish(min-1))
  expect_false(testIntegerish(max+1))
  expect_false(testIntegerish(min-.1))
  expect_false(testIntegerish(max+.1))

  expect_false(testIntegerish(NA, any.missing = FALSE))
  expect_false(testIntegerish(NA, all.missing = FALSE))
  expect_error(assertIntegerish(x, tol=0), "integerish")
})

test_that("bounds of vectors with only missings are not checked", {
  expect_true(checkInteger(NA, lower = 1))
  expect_true(checkInteger(NA_character_, upper = 10))
  expect_fail_all(Integerish, 0, lower = 1L)
  expect_fail_all(Integerish, 100, upper = 10L)
})

test_that("isIntegerish internal function", {
  expect_true(isIntegerish(1))
  expect_true(isIntegerish(1.))
  expect_false(isIntegerish(1.1))
})

test_that("sorted works", {
  expect_true(checkIntegerish(1:3, sorted = TRUE))
  expect_true(grepl("sorted", checkIntegerish(3:1, sorted = TRUE), fixed = TRUE))
})
