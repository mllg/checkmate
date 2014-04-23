context("check_environment")

test_that("check_environment", {
  ee = new.env()
  ee$yyy = 1
  ee$zzz = 1

  expect_false(test(NULL, "environment"))
  expect_false(test(list(), "environment"))
  expect_true(test(ee, "environment"))

  expect_false(test(ee, "environment", contains = "xxx"))
  expect_true(test(ee, "environment", contains = "yyy"))
  expect_true(test(ee, "environment", contains = c("yyy", "zzz")))

  expect_true(assert(ee, "environment"))
  expect_error(assert(list(), "environment"), "environment")
  expect_error(assert(ee, "environment", "xxx"), "named")
})
