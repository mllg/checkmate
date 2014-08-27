context("checkAtomic")

li = list(
  list = list(1, 2),
  factor = factor("a"),
  integer = 1:2,
  NULL = NULL,
  data.frame = iris
)

test_that("checkAtomic", {
  myobj = 1:2
  expect_succ(Atomic, myobj)
  myobj = iris
  expect_fail(Atomic, myobj)

  expect_true(testAtomic(integer(0)))
  expect_true(testAtomic(NULL))
  expect_true(testAtomic(1))
  expect_true(testAtomic(integer(0)))
  expect_true(testAtomic(factor(1)))

  expect_true(testAtomic(NA, any.missing = TRUE))
  expect_false(testAtomic(NA, any.missing = FALSE))
  expect_false(testAtomic(NA, all.missing = FALSE))

  expect_true(testAtomic(1, len=1))
  expect_false(testAtomic(1, len=0))

  expect_true(testAtomic(1, min.len=0))
  expect_false(testAtomic(1, min.len=2))
  expect_true(testAtomic(1, max.len=1))
  expect_false(testAtomic(1, max.len=0))

  expect_true(testAtomic(1, unique=TRUE))
  expect_false(testAtomic(1, min.len=2))
  expect_true(testAtomic(1, max.len=1))
  expect_false(testAtomic(1, max.len=0))

  expect_true(testAtomic(1, unique=TRUE))
  expect_true(testAtomic(c(1,1), unique=FALSE))
  expect_false(testAtomic(c(1,1), unique=TRUE))

  expect_true(testAtomic(1, names="unnamed"))
  expect_true(testAtomic(setNames(1, "x"), names="named"))
  expect_false(testAtomic(1, names="unique"))

  expect_error(assertAtomic(iris), "atomic")

  expect_equal(sapply(li, is.atomic), sapply(li, testAtomic))
})
