context("checkFALSE")

test_that("checkFALSE", {
  expect_succ_all(FALSE, FALSE)
  expect_fail_all(FALSE, 1)

  expect_false(test_false(NA))
  expect_true(test_false(NA, na.ok = TRUE))
})
