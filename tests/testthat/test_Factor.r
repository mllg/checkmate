context("isFactor")

test_that("isFactor", {
  x = factor(c("a", "b"), levels = c("a", "b"))
  expect_true(isFactor(x))
  expect_false(isFactor(integer(1)))
  expect_false(isFactor("a"))
  expect_true(isFactor(factor()))
  expect_false(isFactor(integer(0)))
  expect_false(isFactor(NULL))
  expect_true(isFactor(x, levels = rev(levels(x))))
  expect_true(isFactor(x, empty.levels.ok = FALSE))
  expect_true(isFactor(x, ordered = FALSE))

  expect_false(isFactor(x, levels = c("a")))
  expect_false(isFactor(x, levels = c("a", "b", "c")))

  x = factor(c("a", "b"), levels = c("a", "b", "c"), ordered = TRUE)
  expect_true(isFactor(x, empty.levels.ok = TRUE))
  expect_false(isFactor(x, empty.levels.ok = FALSE))
  expect_true(isFactor(x, ordered = TRUE))
  expect_false(isFactor(x, ordered = FALSE))
})

test_that("assertInteger", {
  x = factor(c("a", "b"), levels = c("a", "b", "c"))
  expect_true(assertFactor(x))
  expect_error(assertFactor(1, "factor"))
  expect_error(assertFactor(x, levels = c("a")), "levels")
  expect_error(assertFactor(x, empty.levels.ok = FALSE), "empty")
  expect_error(assertFactor(x, ordered = TRUE), "ordered")
  x = as.ordered(x)
  expect_error(assertFactor(x, ordered = FALSE), "unordered")
})
