context("which.first / which.last")

test_that("which.first / which.last", {
  x = c(FALSE, TRUE, FALSE, TRUE)
  expect_equal(which.first(x), 2L)
  expect_equal(which.last(x), 4L)

  x = setNames(x, head(letters, length(x)))
  expect_equal(which.first(x), setNames(2L, "b"))
  expect_equal(which.last(x), setNames(4L, "d"))
  expect_equal(which.first(x, use.names=FALSE), 2L)
  expect_equal(which.last(x, use.names=FALSE), 4L)

  x = c(NA, TRUE, NA, TRUE, NA)
  expect_equal(which.first(x), 2L)
  expect_equal(which.last(x), 4L)

  x = logical(0L)
  expect_equal(which.first(x), integer(0L))
  expect_equal(which.last(x), integer(0L))
  expect_equal(which.first(x, use.names=FALSE), integer(0L))
  expect_equal(which.last(x, use.names=FALSE), integer(0L))

  x = c(NA, NA)
  expect_equal(which.first(x), integer(0L))
  expect_equal(which.last(x), integer(0L))
})
