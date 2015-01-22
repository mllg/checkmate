context("anyMissing")

xb = logical(10)
xi = integer(10)
xd = double(10)
xc = complex(10)
xs = letters[1:10]
xl = as.list(1:10)
xm = matrix(1:9, 3)
xf = data.frame(a=1:5, b=1:5)


test_that("anyMissing", {
  expect_false(anyMissing(integer(0)))

  expect_false(anyMissing(xb))
  expect_false(anyMissing(xi))
  expect_false(anyMissing(xd))
  expect_false(anyMissing(xc))
  expect_false(anyMissing(xs))
  expect_false(anyMissing(xl))
  expect_false(anyMissing(xm))
  expect_false(anyMissing(xf))

  xb[5] = xi[5] = xd[5] = xc[5] = xs[5] = xm[2, 2] = xf$b[3] = NA
  xl[5] = list(NULL)
  expect_true(anyMissing(xb))
  expect_true(anyMissing(xi))
  expect_true(anyMissing(xd))
  expect_true(anyMissing(xc))
  expect_true(anyMissing(xs))
  expect_true(anyMissing(xl))
  expect_true(anyMissing(xm))
  expect_true(anyMissing(xf))


  expect_false(anyMissing(as.raw(1)))
  expect_false(anyMissing(NULL))
  expect_error(anyMissing(as.symbol("a")), "supported")
})

test_that("allMissing", {
  expect_true(allMissing(integer(0)))

  expect_false(allMissing(xb))
  expect_false(allMissing(xi))
  expect_false(allMissing(xd))
  expect_false(allMissing(xc))
  expect_false(allMissing(xs))
  expect_false(allMissing(xl))
  expect_false(allMissing(xm))
  expect_false(allMissing(xf))

  xb[5] = xi[5] = xd[5] = xc[5] = xm[2, 2] = xf$b[3] = NA
  xl[5] = list(NULL)

  expect_false(allMissing(xb))
  expect_false(allMissing(xi))
  expect_false(allMissing(xd))
  expect_false(allMissing(xc))
  expect_false(allMissing(xs))
  expect_false(allMissing(xl))
  expect_false(allMissing(xm))
  expect_false(allMissing(xf))


  expect_false(allMissing(as.raw(1)))
  expect_false(allMissing(NULL))
  expect_error(allMissing(as.symbol("a")), "supported")
})
