context("check_factor")

test_that("check_factor", {
  x = factor(c("a", "b"), levels = c("a", "b"))
  expect_true(test(x, "factor"))
  expect_false(test(integer(1), "factor"))
  expect_false(test("a", "factor"))
  expect_true(test(factor(), "factor"))
  expect_false(test(integer(0), "factor"))
  expect_false(test(NULL, "factor"))
  expect_true(test(x, "factor", levels = rev(levels(x))))
  expect_true(test(x, "factor", empty.levels.ok = FALSE))
  expect_true(test(x, "factor", ordered = FALSE))

  expect_false(test(x, "factor", levels = c("a")))
  expect_false(test(x, "factor", levels = c("a", "b", "c")))

  x = factor(c("a", "b"), levels = c("a", "b", "c"), ordered = TRUE)
  expect_true(test(x, "factor", empty.levels.ok = TRUE))
  expect_false(test(x, "factor", empty.levels.ok = FALSE))
  expect_true(test(x, "factor", ordered = TRUE))
  expect_false(test(x, "factor", ordered = FALSE))


  x = factor(c("a", "b"), levels = c("a", "b", "c"))
  expect_true(assert(x, "factor"))
  expect_error(assert(1, "factor"), "factor")
  expect_error(assert(x, "factor", levels = c("a")), "levels")
  expect_error(assert(x, "factor", empty.levels.ok = FALSE), "empty")
  expect_error(assert(x, "factor", ordered = TRUE), "ordered")
  x = as.ordered(x)
  expect_error(assert(x, "factor", ordered = FALSE), "unordered")
})
