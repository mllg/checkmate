context("checkVector")

test_that("checkVector", {
  expect_true(testVector(integer(0)))
  expect_false(testVector(NULL))
  expect_true(testVector(1))
  expect_true(testVector(integer(0)))
  expect_true(testVector(factor(1)))

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

  expect_true(assertVector(1))
  expect_error(assertVector(iris), "vector")
})
