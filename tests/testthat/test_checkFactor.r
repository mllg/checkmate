context("checkFactor")

test_that("checkFactor", {
  myobj = factor(letters[1:2])
  expect_succ(Factor, myobj)
  myobj = letters[1:2]
  expect_fail(Factor, myobj)

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
  expect_error(assertFactor(1), "factor")
  expect_error(assertFactor(x, levels = c("a")), "levels")
  expect_error(assertFactor(x, empty.levels.ok = FALSE), "empty")
  expect_error(assertFactor(x, ordered = TRUE), "ordered")
  x = as.ordered(x)
  expect_error(assertFactor(x, ordered = FALSE), "unordered")


  x = factor(c("a", "b"))
  expect_true(testFactor(x, n.levels = 2))
  expect_true(testFactor(x, min.levels = 2))
  expect_true(testFactor(x, max.levels = 2))
  expect_false(testFactor(x, n.levels = 1))
  expect_false(testFactor(x, min.levels = 3))
  expect_false(testFactor(x, max.levels = 1))

  expect_error(testFactor(x, n.levels = NA))
  expect_error(assertFactor(x, n.levels = 1), "exactly 1 level")
})
