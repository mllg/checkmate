context("checkTibble")

test_that("checkTibble", {
  skip_if_not_physically_installed("tibble")

  expect_false(testTibble(iris))
  expect_true("tibble" %in% loadedNamespaces())

  x = tibble::as_tibble(iris)
  expect_succ_all("DataFrame", x)
  expect_succ_all("Tibble", x)
  expect_fail_all("Tibble", iris)

  expect_true(testTibble(x, min.rows = 1, ncols = 5))
  expect_false(testTibble(x, min.rows = 1000, ncols = 5))

  expect_true(testTibble(x, max.rows = 200, max.cols = 5))
  expect_false(testTibble(x, max.rows = 100))
  expect_false(testTibble(x, max.cols = 3))
})
