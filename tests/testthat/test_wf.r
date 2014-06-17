context("wf / wl")

test_that("wf / wl", {
  wf = checkmate:::wf
  wl = checkmate:::wl
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
})
