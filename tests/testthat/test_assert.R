context("assert")

test_that("assert w/ check*", {
  x = NULL
  expect_true(assert(checkNull(x), checkDataFrame(x)))
  expect_true(assert(checkNull(x)))
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
  expect_true(assert(checkString(x)))
  expect_error(assert(checkNumeric(x), checkCount(x), combine = "or"))
  expect_error(assert(checkNumeric(x), checkCount(x), combine = "and"))
})

