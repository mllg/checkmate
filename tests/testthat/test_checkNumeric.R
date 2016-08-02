context("checkNumeric")

test_that("checkNumeric", {
  myobj = 1
  expect_succ_all(Numeric, myobj)
  myobj = "a"
  expect_fail_all(Numeric, myobj)

  expect_true(testNumeric(integer(0)))
  expect_false(testNumeric(NULL))
  expect_false(testNumeric(TRUE))
  expect_false(testNumeric(FALSE))
  expect_true(testNumeric(NA_character_))
  expect_true(testNumeric(NA_real_))
  expect_true(testNumeric(NaN))
  expect_false(testNumeric(NA_real_, any.missing = FALSE))
  expect_false(testNumeric(NA_real_, all.missing = FALSE))
  expect_false(testNumeric(NaN, any.missing = FALSE))
  expect_false(testNumeric(NaN, all.missing = FALSE))
  expect_true(testNumeric(1L))
  expect_true(testNumeric(1))
  expect_true(testNumeric(Inf))
  expect_true(testNumeric(-Inf))
  expect_identical(assertNumeric(1:2, finite = TRUE), 1:2)
  expect_error(assertNumeric(c(1, Inf), finite = TRUE), "finite")
  expect_error(assertNumeric(c(1, -Inf), finite = TRUE), "finite")
  expect_true(testNumeric(1:3, any.missing=FALSE, min.len=1L, max.len=3L))
  expect_false(testNumeric(1:3, any.missing=FALSE, len=5))
  expect_true(testNumeric(1:3, lower = 1L, upper = 3L))
  expect_false(testNumeric(1:3, lower = 5))

  expect_error(assertNumeric("a"), "numeric")
})

test_that("bounds are checked", {
  expect_error(checkNumeric(1, lower = "a"), "number")
  expect_error(checkNumeric(1, lower = 1:2), "number")
  expect_error(checkNumeric(1, lower = NA_real_), "missing")
  expect_error(checkNumeric(1, upper = "a"), "number")
  expect_error(checkNumeric(1, upper = 1:2), "number")
  expect_error(checkNumeric(1, upper = NA_real_), "missing")
})

test_that("bounds of vectors with only missings are not checked", {
  expect_true(checkNumeric(NA, lower = 1))
  expect_true(checkNumeric(NA_character_, upper = 10))
  expect_fail_all(Numeric, 0:5, lower = 1L)
  expect_fail_all(Numeric, 5:15, upper = 10L)
})
