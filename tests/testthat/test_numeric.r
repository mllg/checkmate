context("check_numeric")

test_that("check_numeric", {
  expect_true(test(integer(0), "numeric"))
  expect_false(test(NULL, "numeric"))
  expect_false(test(TRUE, "numeric"))
  expect_true(test(NA, "numeric"))
  expect_true(test(NA_real_, "numeric"))
  expect_false(test(NA_real_, "numeric", any.missing = FALSE))
  expect_false(test(NA_real_, "numeric", all.missing = FALSE))
  expect_true(test(1L, "numeric"))
  expect_true(test(1, "numeric"))
  expect_true(test(Inf, "numeric"))
  expect_true(test(1:3, "numeric", any.missing=FALSE, min.len=1L, max.len=3L))
  expect_false(test(1:3, "numeric", any.missing=FALSE, len=5))
  expect_true(test(1:3, "numeric", lower = 1L, upper = 3L))
  expect_false(test(1:3, "numeric", lower = 5))


  expect_true(assert(1L, "numeric"))
  expect_error(assert("a", "numeric", "numeric"))
})
