context("assert")

test_that("assert w/ check*", {
  x = NULL
  expect_true(assert(checkNull(x), checkDataFrame(x)))
  grepme = iris
  expect_true(assert(checkNull(grepme), checkDataFrame(grepme)))
  expect_error(assert(checkNull(grepme), checkNumeric(grepme)), "One of")
  expect_error(assert(checkNull(grepme), checkNumeric(grepme)), "grepme")

  x = 1
  expect_true(assert(checkNumeric(x), checkCount(x)))
  expect_true(assert(checkNumeric(x), checkCount(x), combine = "or"))
  expect_true(assert(checkNumeric(x), checkCount(x), combine = "and"))

  x = 1.1
  expect_true(assert(checkNumeric(x), checkCount(x), combine = "or"))
  expect_error(assert(checkNumeric(x), checkCount(x), combine = "and"))

  x = "a"
  expect_error(assert(checkNumeric(x), checkCount(x), combine = "or"))
  expect_error(assert(checkNumeric(x), checkCount(x), combine = "and"))
})

test_that("assert w/ env", {
  x = NULL
  expect_true(assert(null(x), data_frame(x)))
  grepme = iris
  expect_true(assert(null(grepme), data_frame(grepme)))
  expect_error(assert(null(grepme), numeric(grepme)), "One of")
  expect_error(assert(null(grepme), numeric(grepme)), "grepme")

  x = 1
  expect_true(assert(numeric(x), count(x)))
  expect_true(assert(numeric(x), count(x), combine = "or"))
  expect_true(assert(numeric(x), count(x), combine = "and"))

  x = 1.1
  expect_true(assert(numeric(x), count(x), combine = "or"))
  expect_error(assert(numeric(x), count(x), combine = "and"))

  x = "a"
  expect_error(assert(numeric(x), count(x), combine = "or"))
  expect_error(assert(numeric(x), count(x), combine = "and"))
})
