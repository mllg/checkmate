context("checkDouble")

test_that("checkDouble", {
  myobj = 1
  expect_succ_all(Double, myobj)
  myobj = "a"
  expect_fail_all(Double, myobj)

  expect_true(testDouble(integer(0)))
  expect_false(testDouble(NULL))
  expect_false(testDouble(TRUE))
  expect_false(testDouble(FALSE))
  expect_true(testDouble(NA_character_))
  expect_true(testDouble(NA_real_))
  expect_true(testDouble(NaN))
  expect_false(testDouble(NA_real_, any.missing = FALSE))
  expect_false(testDouble(NA_real_, all.missing = FALSE))
  expect_false(testDouble(NaN, any.missing = FALSE))
  expect_false(testDouble(NaN, all.missing = FALSE))
  expect_false(testDouble(1L))
  expect_true(testDouble(1))
  expect_true(testDouble(Inf))
  expect_true(testDouble(-Inf))
  expect_identical(assertDouble(1:2 + 0.1, finite = TRUE), 1:2 + 0.1)
  expect_error(assertDouble(c(1, Inf), finite = TRUE), "finite")
  expect_error(assertDouble(c(1, -Inf), finite = TRUE), "finite")
  expect_true(testDouble(1:3 + 0.1, any.missing=FALSE, min.len=1L, max.len=3L))
  expect_false(testDouble(1:3 + 0.1, any.missing=FALSE, len=5))
  expect_true(testDouble(1:3 + 0.1, lower = 1L, upper = 3.5))
  expect_false(testDouble(1:3 + 0.1, lower = 5))

  expect_error(assertDouble("a"), "double")
})

test_that("bounds are checked", {
  expect_error(checkDouble(1, lower = "a"), "number")
  expect_error(checkDouble(1, lower = 1:2), "length")
  expect_error(checkDouble(1, lower = NA_real_), "missing")
  expect_error(checkDouble(1, upper = "a"), "number")
  expect_error(checkDouble(1, upper = 1:2), "length")
  expect_error(checkDouble(1, upper = NA_real_), "missing")
})

test_that("bounds of vectors with only missings are not checked", {
  expect_true(checkDouble(NA, lower = 1))
  expect_true(checkDouble(NA_character_, upper = 10))
})


test_that("sorted works", {
  xu = runif(10)
  while(!is.unsorted(xu))
    xu = runif(10)
  xs = sort(xu)

  expect_true(checkDouble(xs, sorted = TRUE))
  expect_true(grepl("sorted", checkDouble(xu, sorted = TRUE), fixed = TRUE))

  expect_true(checkDouble(1., sorted = TRUE))
  expect_true(checkDouble(double(0), sorted = TRUE))
  expect_true(checkDouble(NA_real_, sorted = TRUE))
  expect_true(checkInteger(rep(NA_real_, 10), sorted = TRUE))

  for (i in 1:10) {
    x = sample(10)
    x[sample(10, sample(7:9, 1))] = NA
    if (is.unsorted(na.omit(x)))
      expect_true(grepl("sorted", checkDouble(xu, sorted = TRUE), fixed = TRUE))
    else
      expect_true(grepl("sorted", checkDouble(xu, sorted = TRUE), fixed = TRUE))
  }
})
