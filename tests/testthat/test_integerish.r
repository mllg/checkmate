context("test")

test_that("test", {
  expect_true(test(integer(0), "integerish"))
  expect_false(test(NULL, "integerish"))
  expect_true(test(TRUE, "integerish"))
  expect_true(test(FALSE, "integerish"))
  expect_true(test(1L, "integerish"))
  expect_true(test(c(-1, 0, 1), "integerish"))
  expect_true(test(1., "integerish"))
  expect_true(test(1 - .9 - .1, "integerish"))

  expect_true(test(NA, "integerish"))
  expect_true(test(NaN, "integerish"))
  expect_true(test(c(1L, NA), "integerish"))
  expect_true(test(c(1, NA), "integerish"))
  expect_true(test(c(1, NaN), "integerish"))

  expect_false(test(1:2 + 0.0001, "integerish"))
  expect_false(test(-Inf, "integerish"))
  expect_false(test(Inf, "integerish"))

  expect_false(test(3+2i, "integerish"))
  expect_false(test(list(), "integerish"))

  max = as.double(.Machine$integer.max)
  min = as.double(-.Machine$integer.max)
  expect_true(test(min, "integerish"))
  expect_true(test(max, "integerish"))
  expect_false(test(min-1, "integerish"))
  expect_false(test(max+1, "integerish"))
  expect_false(test(min-.1, "integerish"))
  expect_false(test(max+.1, "integerish"))


  expect_true(assert(1, "integerish"))
  expect_true(assert(1-.9-.1, "integerish"), "integer-ish")
  expect_error(assert(1-.9-.1, "integerish", tol=0), "integer-ish")
})
