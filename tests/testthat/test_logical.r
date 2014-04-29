context("check_logical")

test_that("check_logical", {
  expect_true(test(logical(0), "logical"))
  expect_false(test(NULL, "logical"))
  expect_true(test(TRUE, "logical"))
  expect_true(test(NA, "logical"))
  expect_true(test(NA_real_, "logical"))
  expect_true(test(FALSE, "logical"))
  expect_false(test(NA, "logical", any.missing=FALSE))
  expect_false(test(NA, "logical", all.missing=FALSE))
  expect_false(test(iris, "logical"))
  expect_true(test(c(TRUE, FALSE), "logical", min.len = 2))

  expect_true(assert(TRUE, "logical"))
  expect_error(assert(1, "logical", "logical"))
})
