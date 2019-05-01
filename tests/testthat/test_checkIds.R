context("checkIds")

test_that("checkIds", {
  nn = letters[1:3]
  expect_succ_all(Ids, nn)
  nn = c(nn, "ä")
  expect_fail_all(Ids, nn)

  expect_true(testIds(c("a", "b", "a"), unique = FALSE))
  expect_false(testIds(c("a", "b", "a"), unique = TRUE))
  expect_true(testIds(c("a", "b"), len = 2L))
  expect_true(testIds(c("a", "b"), min.len = 2L))
  expect_false(testIds(c("a", "b"), len = 3L))
  expect_false(testIds(c("a", "b"), min.len = 3L))
})
