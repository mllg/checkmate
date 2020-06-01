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

test_that("correct variable is reported (#182)", {
  f = function(a, b) assert(checkFunction(a), checkNumeric(b), combine = "and")
  expect_error(f(identity, "a"), "'b'")
})

test_that("can push to collection", {
  coll = makeAssertCollection()
  x = NULL
  expect_error(assert(checkNull(x), .var.name = c("a", "b"), add = coll), "length")
  expect_error(assert(checkNull(x), add = "not_assert_coll"), "AssertCollection")
  expect_true(assert(checkNull(x), add = coll))
  expect_true(coll$isEmpty())
  expect_true(assert(checkNull(x), checkDataFrame(x), add = coll))
  expect_true(coll$isEmpty())
  grepme = iris
  expect_true(assert(checkNull(grepme), checkDataFrame(grepme), add = coll))
  expect_true(coll$isEmpty())
  assert(checkNull(grepme), checkNumeric(grepme), add = coll)
  expect_match(
    coll$getMessages(), "Variable.+One of")
  assert(checkNull(grepme), checkNumeric(x), add = coll)
  expect_match(
    coll$getMessages()[2], "Variables.+grepme.+x.+One of")
  assert(
    checkNull(grepme), checkNumeric(x), .var.name = "TEST", add = coll)
  expect_match(
    coll$getMessages()[3], "Variable.+TEST.+One of")
  assert(
    checkNull(grepme), checkNumeric(x), .var.name = c("V1", "V2"), add = coll)
  expect_match(
    coll$getMessages()[4], "Variable.+V1.+V2.+One of")
})