context("checkFactor")

test_that("checkFactor", {
  x = factor(c("a", "b"), levels = c("a", "b"))
  expect_true(testFactor(x))
  expect_false(testFactor(integer(1)))
  expect_false(testFactor("a"))
  expect_true(testFactor(factor()))
  # expect_false(testFactor(integer(0)))
  expect_false(testFactor(NULL))
  expect_true(testFactor(x, levels = rev(levels(x))))
  expect_true(testFactor(x, empty.levels.ok = FALSE))
  expect_true(testFactor(x, ordered = FALSE))

  expect_false(testFactor(x, levels = c("a")))
  expect_false(testFactor(x, levels = c("a", "b", "c")))

  x = factor(c("a", "b"), levels = c("a", "b", "c"), ordered = TRUE)
  expect_true(testFactor(x, empty.levels.ok = TRUE))
  expect_false(testFactor(x, empty.levels.ok = FALSE))
  expect_true(testFactor(x, ordered = TRUE))
  expect_false(testFactor(x, ordered = FALSE))


  x = factor(c("a", "b"), levels = c("a", "b", "c"))
  expect_true(assertFactor(x))
  expect_error(assertFactor(1))
  expect_error(assertFactor(x, levels = c("a")), "levels")
  expect_error(assertFactor(x, empty.levels.ok = FALSE), "empty")
  expect_error(assertFactor(x, ordered = TRUE), "ordered")
  x = as.ordered(x)
  expect_error(assertFactor(x, ordered = FALSE), "unordered")
})
