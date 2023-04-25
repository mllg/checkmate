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
  expect_error(checkNumeric(1, lower = 1:2), "length")
  expect_error(checkNumeric(1, lower = NA_real_), "missing")
  expect_error(checkNumeric(1, upper = "a"), "number")
  expect_error(checkNumeric(1, upper = 1:2), "length")
  expect_error(checkNumeric(1, upper = NA_real_), "missing")
})

test_that("bounds of vectors with only missings are not checked", {
  expect_true(checkNumeric(NA, lower = 1))
  expect_true(checkNumeric(NA_character_, upper = 10))
  expect_fail_all(Numeric, 0:5, lower = 1L)
  expect_fail_all(Numeric, 5:15, upper = 10L)
})


test_that("sorted works", {
  xu = runif(10)
  while(!is.unsorted(xu))
    xu = runif(10)
  xs = sort(xu)

  expect_true(checkNumeric(xs, sorted = TRUE))
  expect_true(grepl("sorted", checkNumeric(xu, sorted = TRUE), fixed = TRUE))

  expect_true(checkNumeric(1., sorted = TRUE))
  expect_true(checkNumeric(double(0), sorted = TRUE))
  expect_true(checkNumeric(NA_real_, sorted = TRUE))
  expect_true(checkInteger(rep(NA_real_, 10), sorted = TRUE))

  for (i in 1:10) {
    x = sample(10)
    x[sample(10, sample(7:9, 1))] = NA
    if (is.unsorted(na.omit(x)))
      expect_true(grepl("sorted", checkNumeric(xu, sorted = TRUE), fixed = TRUE))
    else
      expect_true(grepl("sorted", checkNumeric(xu, sorted = TRUE), fixed = TRUE))
  }
})

test_that("names check works", {
  expect_true(grepl("names", check_numeric(0:1, names = "unique")))
})


test_that("typed.missing", {
  expect_true(testNumeric(NA))
  expect_true(testNumeric(NA, typed.missing = FALSE))
  expect_false(testNumeric(NA, typed.missing = TRUE))

  expect_true(testNumeric(character()))
  expect_true(testNumeric(character(), typed.missing = FALSE))
  expect_false(testNumeric(character(), typed.missing = TRUE))
})

test_that("Inf bound checks", {
  expect_false(testNumeric(2, lower = Inf))
  expect_true(testNumeric(2, lower = -Inf))
  expect_true(testNumeric(2, upper = Inf))
  expect_false(testNumeric(2, upper = -Inf))
})
