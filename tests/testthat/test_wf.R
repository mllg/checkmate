context("wf / wl")

test_that("wf / wl", {
  x = c(FALSE, TRUE, FALSE, TRUE)
  expect_equal(wf(x), 2L)
  expect_equal(wl(x), 4L)

  x = c(NA, TRUE, NA, TRUE, NA)
  expect_equal(wf(x), 2L)
  expect_equal(wl(x), 4L)

  x = logical(0L)
  expect_equal(wf(x), integer(0L))
  expect_equal(wl(x), integer(0L))
  expect_equal(wf(x), integer(0L))
  expect_equal(wl(x), integer(0L))

  x = c(NA, NA)
  expect_equal(wf(x), integer(0L))
  expect_equal(wl(x), integer(0L))

  x = setNames(c(NA, FALSE, TRUE, FALSE, TRUE, FALSE, NA), letters[1:7])
  expect_identical(wf(x, TRUE), setNames(3L, "c"))
  expect_identical(wf(x, FALSE), 3L)
  expect_identical(wl(x), setNames(5L, "e"))
  expect_identical(wl(x, FALSE), 5L)
  expect_equal(wf(logical(0)), integer(0))
  expect_equal(wl(logical(0)), integer(0))

  expect_error(wf(42), "logical")
  expect_error(wl(42), "logical")
  expect_error(wf(NA, iris), "use.names")
  expect_error(wl(NA, iris), "use.names")
})
