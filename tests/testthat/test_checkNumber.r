context("checkNumber")

test_that("checkNumber", {
  myobj = 1
  expect_succ(Number, myobj)
  myobj = "a"
  expect_fail(Number, myobj)

  expect_false(testNumber(integer(0)))
  expect_false(testNumber(NULL))

  expect_true(testNumber(1L))
  expect_true(testNumber(1.))
  expect_false(testNumber(NA))
  expect_false(testNumber(NaN))
  expect_true(testNumber(NaN, na.ok = TRUE))
  expect_true(testNumber(NA_real_, na.ok = TRUE))
  expect_false(testNumber(1:2))
  expect_false(testNumber(""))

  expect_true(testNumber(Inf))
  expect_true(testNumber(-Inf))
  expect_error(assertNumber(Inf, finite = TRUE), "finite")
  expect_error(assertNumber(-Inf, finite = TRUE), "finite")

  expect_false(testNumber(TRUE))

  expect_error(assertNumber(2+3i), "number")
})
