context("asInteger")

test_that("asInteger", {
  xi = 1:5
  xd = as.double(1:5)
  xc = as.complex(1:5)

  expect_equal(asInteger(xi), xi)
  expect_equal(asInteger(xd), xi)
  expect_equal(asInteger(xc), xi)
  expect_equal(asInteger(NA), NA_integer_)

  expect_error(asInteger("a"), "converting")
  expect_error(asInteger(3+1i))
  expect_error(asInteger(iris))
})
