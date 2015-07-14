context("anyNaN")

test_that("anyNaN", {
  xb = logical(10)
  xi = integer(10)
  xd = double(10)
  xc = complex(10)
  xl = as.list(1:10)
  xm = matrix(1:9, 3)
  xf = data.frame(a=1:5, b=1:5)

  expect_false(anyNaN(NULL))
  expect_false(anyNaN(mean))
  expect_false(anyNaN(double(0)))

  expect_false(anyNaN(xb))
  expect_false(anyNaN(xi))
  expect_false(anyNaN(xd))
  expect_false(anyNaN(xc))
  expect_false(anyNaN(xl))
  expect_false(anyNaN(xm))
  expect_false(anyNaN(xf))

  xd[5] = xc[5] = xf$b[3] = NaN
  xl[5] = NaN
  expect_true(anyNaN(xd))
  expect_true(anyNaN(xc))
  expect_true(anyNaN(xl))
  expect_true(anyNaN(xf))

  x = list(1, list(1, list(1, NaN)))
  expect_true(anyNaN(x))
})
