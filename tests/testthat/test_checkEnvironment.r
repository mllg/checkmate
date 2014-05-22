context("checkEnvironment")

test_that("checkEnvironment", {
  ee = new.env(parent = emptyenv())
  ee$yyy = 1
  ee$zzz = 1

  expect_false(testEnvironment(NULL))
  expect_false(testEnvironment(list()))
  expect_true(testEnvironment(ee))

  expect_false(testEnvironment(ee, contains = "xxx"))
  expect_true(testEnvironment(ee, contains = "yyy"))
  expect_true(testEnvironment(ee, contains = c("yyy", "zzz")))

  expect_true(assertEnvironment(ee))
  expect_error(assertEnvironment(list()))
  expect_error(assertEnvironment(ee, "xxx"), "with name")
})
