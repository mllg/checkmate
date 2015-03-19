context("checkVector")

li = list(
  list = list(1, 2),
  factor = factor("a"),
  integer = 1:2,
  NULL = NULL,
  data.frame = iris
)

test_that("checkVector", {
  myobj = 1:3
  expect_succ(Vector, myobj)
  myobj = NULL
  expect_fail(Vector, myobj)

  expect_true(testVector(integer(0)))
  expect_false(testVector(NULL))
  expect_true(testVector(1))
  expect_true(testVector(integer(0)))
  expect_true(testVector(factor(1), strict = FALSE))
  expect_false(testVector(factor(1), strict = TRUE))

  expect_true(testVector(NA, any.missing = TRUE))
  expect_false(testVector(NA, any.missing = FALSE))
  expect_false(testVector(NA, all.missing = FALSE))

  expect_true(testVector(1, len=1))
  expect_false(testVector(1, len=0))

  expect_true(testVector(1, min.len=0))
  expect_false(testVector(1, min.len=2))
  expect_true(testVector(1, max.len=1))
  expect_false(testVector(1, max.len=0))

  expect_true(testVector(1, unique=TRUE))
  expect_false(testVector(1, min.len=2))
  expect_true(testVector(1, max.len=1))
  expect_false(testVector(1, max.len=0))

  expect_true(testVector(1, unique=TRUE))
  expect_true(testVector(c(1,1), unique=FALSE))
  expect_false(testVector(c(1,1), unique=TRUE))

  expect_true(testVector(1, names="unnamed"))
  expect_true(testVector(setNames(1, "x"), names="named"))
  expect_false(testVector(1, names="unique"))

  expect_equal(sapply(li, is.vector), sapply(li, testVector, strict = TRUE))
  expected = setNames(c(TRUE, TRUE, TRUE, FALSE, TRUE), c("list", "factor", "integer", "NULL", "data.frame"))
  expect_equal(expected, sapply(li, testVector, strict = FALSE))

  expect_error(assertVector(iris, strict = TRUE), "vector")
})

test_that("arguments any.missing and all.missing are checked", {
  x = 1
  expect_error(checkVector(x, any.missing = 1), "flag")
  expect_error(checkVector(x, any.missing = NA), "missing")
  expect_error(checkVector(x, all.missing = 1), "flag")
  expect_error(checkVector(x, all.missing = NA), "missing")
})

test_that("length is correctly reported", {
  x = 1:42
  expect_true(grepl(42, checkVector(x, len = 1), fixed = TRUE))
  expect_true(grepl(42, checkVector(x, min.len = 43), fixed = TRUE))
  expect_true(grepl(42, checkVector(x, max.len = 1), fixed = TRUE))
  expect_true(grepl(43, checkVector(x, len = 43), fixed = TRUE))
  expect_true(grepl(43, checkVector(x, min.len = 43), fixed = TRUE))
  expect_true(grepl(41, checkVector(x, max.len = 41), fixed = TRUE))
})
