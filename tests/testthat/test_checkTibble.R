context("checkTibble")

test_that("checkTibble", {
  skip_if_not_installed("tibble")
  requireNamespace("tibble")

  x = tibble::as_tibble(iris)
  expect_succ_all("DataFrame", x)
  expect_succ_all("Tibble", x)
  expect_fail_all("Tibble", iris)

  expect_true(testTibble(x, min.rows = 1, ncols = 5))
  expect_false(testTibble(x, min.rows = 1000, ncols = 5))
})
