context("isVector")

test_that("isVector", {
  expect_true(isVector(integer(0)))
  expect_false(isVector(NULL))
  expect_true(isVector(1))
  expect_true(isVector(integer(0)))

  expect_true(isVector(NA, na.ok=TRUE))
  expect_false(isVector(NA, na.ok=FALSE))

  expect_true(isVector(1, len=1))
  expect_false(isVector(1, len=0))

  expect_true(isVector(1, min.len=0))
  expect_false(isVector(1, min.len=2))
  expect_true(isVector(1, max.len=1))
  expect_false(isVector(1, max.len=0))
})

test_that("assertString", {
  expect_true(assertVector(1))
  expect_error(assertString(NA, "string"))
})
