context("checkAtomicVector")

li = list(
  list = list(1, 2),
  factor = factor("a"),
  integer = 1:2,
  NULL = NULL,
  data.frame = iris
)

test_that("checkAtomicVector", {
  myobj = 1:2
  expect_succ(AtomicVector, myobj)
  myobj = NULL
  expect_fail(AtomicVector, myobj)

  expect_true(testAtomicVector(integer(0)))
  expect_false(testAtomicVector(NULL))
  expect_true(testAtomicVector(1))
  expect_true(testAtomicVector(integer(0)))
  expect_true(testAtomicVector(factor(1)))

  expect_true(testAtomicVector(NA, any.missing = TRUE))
  expect_false(testAtomicVector(NA, any.missing = FALSE))
  expect_false(testAtomicVector(NA, all.missing = FALSE))

  expect_true(testAtomicVector(1, len=1))
  expect_false(testAtomicVector(1, len=0))

  expect_true(testAtomicVector(1, min.len=0))
  expect_false(testAtomicVector(1, min.len=2))
  expect_true(testAtomicVector(1, max.len=1))
  expect_false(testAtomicVector(1, max.len=0))

  expect_true(testAtomicVector(1, unique=TRUE))
  expect_false(testAtomicVector(1, min.len=2))
  expect_true(testAtomicVector(1, max.len=1))
  expect_false(testAtomicVector(1, max.len=0))

  expect_true(testAtomicVector(1, unique=TRUE))
  expect_true(testAtomicVector(c(1,1), unique=FALSE))
  expect_false(testAtomicVector(c(1,1), unique=TRUE))

  expect_true(testAtomicVector(1, names="unnamed"))
  expect_true(testAtomicVector(setNames(1, "x"), names="named"))
  expect_false(testAtomicVector(1, names="unique"))

  expect_error(assertAtomicVector(iris), "atomic")

  expected = setNames(c(FALSE, TRUE, TRUE, FALSE, FALSE), c("list", "factor", "integer", "NULL", "data.frame"))
  expect_equal(expected, sapply(li, testAtomicVector))
})
