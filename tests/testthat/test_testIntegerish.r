context("checkIntegerish")

test_that("checkIntegerish", {
  expect_true(checkIntegerish(integer(0)))
  expect_false(checkIntegerish(NULL))
  expect_true(checkIntegerish(TRUE))
  expect_true(checkIntegerish(FALSE))
  expect_true(checkIntegerish(1L))
  expect_true(checkIntegerish(c(-1, 0, 1)))
  expect_true(checkIntegerish(1.))
  expect_true(checkIntegerish(1 - .9 - .1))

  expect_true(checkIntegerish(NA))
  expect_true(checkIntegerish(NaN))
  expect_true(checkIntegerish(c(1L, NA)))
  expect_true(checkIntegerish(c(1, NA)))
  expect_true(checkIntegerish(c(1, NaN)))

  expect_false(checkIntegerish(1:2 + 0.0001))
  expect_false(checkIntegerish(-Inf))
  expect_false(checkIntegerish(Inf))

  expect_false(checkIntegerish(3+2i))
  expect_false(checkIntegerish(list()))

  max = as.double(.Machine$integer.max)
  min = as.double(-.Machine$integer.max)
  expect_true(checkIntegerish(min))
  expect_true(checkIntegerish(max))
  expect_false(checkIntegerish(min-1))
  expect_false(checkIntegerish(max+1))
  expect_false(checkIntegerish(min-.1))
  expect_false(checkIntegerish(max+.1))
})

test_that("assertIntegerish", {
  expect_true(assertIntegerish(1), "integer-ish")
  expect_true(assertIntegerish(1-.9-.1), "integer-ish")
  expect_error(assertIntegerish(1-.9-.1, tol=0), "integer-ish")
})
