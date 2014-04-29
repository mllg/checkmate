context("check_flag")

test_that("check_flag", {
  expect_false(test(logical(0), "flag"))
  expect_false(test(NULL, "flag"))
  expect_true(test(TRUE, "flag"))
  expect_true(test(FALSE, "flag"))
  expect_false(test(NA, "flag"))
  expect_true(test(NA, "flag", na.ok = TRUE))
  expect_true(test(NA_character_, "flag", na.ok = TRUE))
  expect_false(test(iris, "flag"))

  expect_true(assert(TRUE, "flag"))
  expect_error(assert(1, "flag", "flag"))
})
