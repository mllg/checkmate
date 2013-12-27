context("any.missing")


test_that("any.missing", {
  xb = logical(10)
  xi = integer(10)
  xd = double(10)
  xc = complex(10)
  xl = as.list(1:10)
  xm = matrix(1:9, 3)
  xf = data.frame(a=1:5, b=1:5)
  expect_false(any.missing(xb))
  expect_false(any.missing(xi))
  expect_false(any.missing(xd))
  expect_false(any.missing(xc))
  expect_false(any.missing(xl))
  expect_false(any.missing(xm))
  expect_false(any.missing(xf))

  xb[5] = xi[5] = xd [5] = xc[5] = xm[2, 2] = xf$b[3] = NA
  xl[5] = list(NULL)
  expect_true(any.missing(xb))
  expect_true(any.missing(xi))
  expect_true(any.missing(xd))
  expect_true(any.missing(xc))
  expect_true(any.missing(xl))
  expect_true(any.missing(xm))
  expect_true(any.missing(xf))
})
