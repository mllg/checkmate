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

test_that("bug #69", {
  sub = subset = 1:150
  res = assert(checkIntegerish(subset), checkLogical(subset, len = 150))
  expect_true(res)
  res = assert(checkIntegerish(sub), checkLogical(sub, len = 150))
  expect_true(res)
})
