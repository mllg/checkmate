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

  expect_error(assertDate(letters, unique = TRUE), "character")
})

test_that("NAs are ignored for dates' lower-bound", {
  # Define and test a nomal date vector, and an empty date vector.
  d <- as.Date(c("2015-01-01", "2016-01-01", NA_character_, "2017-01-01"))
  empty <- as.Date(character(0))
  nas <- as.Date(NA_character_, NA_character_, NA_character_)

  # Bounds pass/fail appropriately when missing values are legal.
  expect_true( testDate(d    , lower = "1980-01-01", any.missing = TRUE ))
  expect_false(testDate(d    , lower = "2016-01-01", any.missing = TRUE ))

  # Bounds are ignored when missing values are illegal (and the vector contains missing values).
  expect_false(testDate(d    , lower = "1980-01-01", any.missing = FALSE))
  expect_false(testDate(d    , lower = "2016-01-01", any.missing = FALSE))

  # Zero-length date vectors never fail with a lower bound.
  expect_true( testDate(empty, lower  ="2030-01-01", any.missing = TRUE ))
  expect_true( testDate(empty, lower  ="2030-01-01", any.missing = FALSE))

  # NA date vectors
  expect_true( testDate(nas  , lower  ="2030-01-01", any.missing = TRUE ))
  expect_false(testDate(nas  , lower  ="2030-01-01", any.missing = FALSE))
})

test_that("NAs are ignored for dates' upper-bound", {
  # Define and test a nomal date vector, and an empty date vector.
  d <- as.Date(c("2015-01-01", "2016-01-01", NA_character_, "2017-01-01"))
  empty <- as.Date(character(0))
  nas <- as.Date(NA_character_, NA_character_, NA_character_)

  # Bounds pass/fail appropriately when missing values are legal.
  expect_true( testDate(d    , upper = "2020-01-01", any.missing = TRUE ))
  expect_false(testDate(d    , upper = "2016-01-01", any.missing = TRUE ))

  # Bounds are ignored when missing values are illegal (and the vector contains missing values).
  expect_false(testDate(d    , upper = "2020-01-01", any.missing = FALSE))
  expect_false(testDate(d    , upper = "2016-01-01", any.missing = FALSE))

  # Zero-length date vectors never fail with a upper bound.
  expect_true( testDate(empty, upper = "2000-01-01", any.missing = FALSE))
  expect_true( testDate(empty, upper = "2000-01-01", any.missing = FALSE))

  # NA date vectors
  expect_true( testDate(nas  , lower  ="2030-01-01", any.missing = TRUE ))
  expect_false(testDate(nas  , lower  ="2030-01-01", any.missing = FALSE))
})
