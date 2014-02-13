context("is.integerish")

test_that("is.integerish", {
  expect_true(is.integerish(TRUE))
  expect_true(is.integerish(FALSE))
  expect_true(is.integerish(1L))
  expect_true(is.integerish(c(-1, 0, 1)))
  expect_true(is.integerish(1.))
  expect_true(is.integerish(1 - .9 - .1))

  expect_true(is.integerish(NA))
  expect_true(is.integerish(NaN))
  expect_true(is.integerish(c(1L, NA)))
  expect_true(is.integerish(c(1, NA)))
  expect_true(is.integerish(c(1, NaN)))

  expect_false(is.integerish(1:2 + 0.0001))
  expect_false(is.integerish(-Inf))
  expect_false(is.integerish(Inf))

  expect_false(is.integerish(3+2i))
  expect_false(is.integerish(list()))

  max = as.double(.Machine$integer.max)
  min = as.double(-.Machine$integer.max)
  expect_true(is.integerish(min))
  expect_true(is.integerish(max))
  expect_false(is.integerish(min-1))
  expect_false(is.integerish(max+1))
  expect_false(is.integerish(min-.1))
  expect_false(is.integerish(max+.1))
})
