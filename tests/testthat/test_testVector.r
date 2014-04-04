context("checkVector")

test_that("checkVector", {
  expect_true(checkVector(integer(0)))
  expect_false(checkVector(NULL))
  expect_true(checkVector(1))
  expect_true(checkVector(integer(0)))

  expect_true(checkVector(NA, na.ok=TRUE))
  expect_false(checkVector(NA, na.ok=FALSE))

  expect_true(checkVector(1, len=1))
  expect_false(checkVector(1, len=0))

  expect_true(checkVector(1, min.len=0))
  expect_false(checkVector(1, min.len=2))
  expect_true(checkVector(1, max.len=1))
  expect_false(checkVector(1, max.len=0))
})

test_that("assertString", {
  expect_true(assertVector(1))
  expect_error(assertString(NA, "string"))
})
