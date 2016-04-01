context("checkDate")

test_that("checkDate", {
  x = Sys.Date()
  expect_succ_all(Date, x)
  expect_fail_all(Date, 1)

  expect_true(testDate(x, lower = 1))
  expect_true(testDate(x, upper = as.integer(x + 2)))
  expect_error(assertDate(x, lower = x + 2), ">=")
  expect_error(assertDate(x, upper = x - 2), "<=")

  expect_true(testDate(x, upper = x + 2))
  expect_false(testDate(x, upper = x - 2))
  expect_true(testDate(x, lower = x - 2))
  expect_false(testDate(x, lower = x + 2))

  expect_error(assertDate(x, lower = 1:2), "single")
  expect_error(assertDate(x, lower = NA), "single")
  expect_error(assertDate(x, lower = integer(0)), "single")
  expect_error(assertDate(x, upper = 1:2), "single")
  expect_error(assertDate(x, upper = NA), "single")
  expect_error(assertDate(x, upper = integer(0)), "single")


  x = as.Date(NA)
  expect_error(assertDate(x, any.missing = FALSE), "missing")
  x = rep(Sys.Date(), 2)
  expect_error(assertDate(x, unique = TRUE), "duplicated")
})
