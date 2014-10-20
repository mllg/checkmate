context("checkPercentage")

test_that("checkPercentage", {
  myobj = 1
  expect_succ(Percentage, myobj)
  myobj = 2
  expect_fail(Percentage, myobj)

  expect_false(testPercentage(integer(0)))
  expect_false(testPercentage(NULL))
  expect_false(testPercentage(-1))

  expect_true(testPercentage(1L))
  expect_true(testPercentage(1.))
  expect_false(testPercentage(NA))
  expect_false(testPercentage(NaN))
  expect_true(testPercentage(NaN, na.ok = TRUE))
  expect_true(testPercentage(NA_real_, na.ok = TRUE))
  expect_false(testPercentage(1:2))
  expect_false(testPercentage(""))

  expect_false(testPercentage(TRUE))
  expect_error(assertPercentage(2+3i), "number")
})
