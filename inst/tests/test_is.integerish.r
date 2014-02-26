context("isIntegerish")

test_that("isIntegerish", {
  expect_true(isIntegerish(TRUE))
  expect_true(isIntegerish(FALSE))
  expect_true(isIntegerish(1L))
  expect_true(isIntegerish(c(-1, 0, 1)))
  expect_true(isIntegerish(1.))
  expect_true(isIntegerish(1 - .9 - .1))

  expect_true(isIntegerish(NA))
  expect_true(isIntegerish(NaN))
  expect_true(isIntegerish(c(1L, NA)))
  expect_true(isIntegerish(c(1, NA)))
  expect_true(isIntegerish(c(1, NaN)))

  expect_false(isIntegerish(1:2 + 0.0001))
  expect_false(isIntegerish(-Inf))
  expect_false(isIntegerish(Inf))

  expect_false(isIntegerish(3+2i))
  expect_false(isIntegerish(list()))

  max = as.double(.Machine$integer.max)
  min = as.double(-.Machine$integer.max)
  expect_true(isIntegerish(min))
  expect_true(isIntegerish(max))
  expect_false(isIntegerish(min-1))
  expect_false(isIntegerish(max+1))
  expect_false(isIntegerish(min-.1))
  expect_false(isIntegerish(max+.1))
})
