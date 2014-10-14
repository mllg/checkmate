context("anyInfinite")

test_that("anyInfinite", {
  xb = logical(10)
  xi = integer(10)
  xd = double(10)
  xc = complex(10)
  xl = as.list(1:10)
  xm = matrix(1:9, 3)
  xf = data.frame(a=1:5, b=1:5)

  expect_false(anyInfinite(NULL))
  expect_false(anyInfinite(mean))
  expect_false(anyInfinite(double(0)))

  expect_false(anyInfinite(xb))
  expect_false(anyInfinite(xi))
  expect_false(anyInfinite(xd))
  expect_false(anyInfinite(xc))
  expect_false(anyInfinite(xl))
  expect_false(anyInfinite(xm))
  expect_false(anyInfinite(xf))

  xd[5] = xc[5] = xf$b[3] = Inf
  xl[5] = -Inf
  expect_true(anyInfinite(xd))
  expect_true(anyInfinite(xc))
  expect_true(anyInfinite(xl))
  expect_true(anyInfinite(xf))

  x = list(1, list(1, list(1, Inf)))
  expect_true(anyInfinite(x))
})
