context("checkPermutation")

test_that("checkPermutation", {
  expect_false(testPermutation(1L, c(1L, 2L)))
  expect_true(testPermutation(2:1, 1:2))

  expect_false(testPermutation(1, c(1, 2)))
  expect_true(testPermutation(c(2, 1), c(1, 2)))

  expect_true(testPermutation(letters[1:2], letters[2:1]))
  expect_false(testPermutation(letters[c(1, 1, 2)], letters[1:2]))

  expect_true(testPermutation(as.factor(letters[1:2]), as.factor(letters[2:1])))
  expect_false(testPermutation(as.factor(letters[c(1, 1, 2)]), as.factor(letters[1:2])))

  expect_true(testPermutation(as.ordered(letters[1:2]), as.ordered(letters[2:1])))
  expect_false(testPermutation(as.ordered(letters[c(1, 1, 2)]), as.ordered(letters[1:2])))

  expect_true(testPermutation(c(1 + 2i, 1), c(1, 1 + 2i)))
  expect_false(testPermutation(c(1 + 2i, 1 + 3i), c(1, 1 + 2i)))

  expect_true(testPermutation(c(FALSE, TRUE, NA), c(NA, TRUE, FALSE)))
  expect_false(testPermutation(c(FALSE, TRUE, NA, NA), c(NA, TRUE, FALSE)))

  expect_true(testPermutation(c(NA, 1), c(1, NA)))
  expect_false(testPermutation(c(1, 1, 1), c(1)))
  expect_true(testPermutation(1, 1L))
  expect_false(testPermutation(c(1, 1, 2), c(2, 2, 1)))
  expect_false(testPermutation(c("a", NA, "b", "b", NA), c(NA, NA, "a", "b", "a")))
  expect_true(testPermutation(c("a", NA, "b", "b", NA), c(NA, NA, "b", "b", "a")))
  expect_false(testPermutation(c("a", NA, "b", "b"), c(NA, NA, "b", "b", "a")))

  expect_false(testPermutation(c(1, NA), c(NA, 1), na.ok = FALSE))
  expect_false(testPermutation(c(1, NA), c(1)))
})
