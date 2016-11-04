context("checkTRUE")

test_that("checkTRUE", {
  expect_succ_all(TRUE, TRUE)
  expect_fail_all(TRUE, 1)

  expect_false(test_true(NA))
  expect_true(test_true(NA, na.ok = TRUE))
})
