context("asType")

test_that("asInteger", {
  xi = 1:5
  xd = as.double(1:5)
  xc = as.complex(1:5)

  expect_equal(asInteger(xi), xi)
  expect_equal(asInteger(xd), xi)
  expect_equal(asInteger(xc), xi)
  expect_equal(asInteger(NA), NA_integer_)

  expect_equal(names(asInteger(xi)), names(xi))
  expect_equal(names(asInteger(xd)), names(xd))
  expect_equal(names(asInteger(xc)), names(xc))
  names(xi) = names(xd) = names(xc) = letters[1:5]
  expect_equal(names(asInteger(xi)), names(xi))
  expect_equal(names(asInteger(xd)), names(xd))
  expect_equal(names(asInteger(xc)), names(xc))

  expect_error(asInteger("a"))
  expect_error(asInteger(3+1i))
  expect_error(asInteger(iris))
  expect_error(asInteger(NA, any.missing = FALSE), "missing")
})

test_that("asInt", {
  xi = 1L
  xd = 1.
  xc = as.complex(1)

  expect_equal(names(asInt(xi)), names(xi))
  expect_equal(names(asInt(xd)), names(xd))
  expect_equal(names(asInt(xc)), names(xc))
  names(xi) = names(xd) = names(xc) = "a"
  expect_equal(names(asInt(xi)), names(xi))
  expect_equal(names(asInt(xd)), names(xd))
  expect_equal(names(asInt(xc)), names(xc))

  expect_error(asInt(1:2), "integerish")
  expect_equal(asInt(xi), xi)
  expect_equal(asInt(xd), xi)
  expect_equal(asInt(xc), xi)
  expect_error(asInt(NA), "NA")
  expect_equal(asInt(NA, na.ok = TRUE), NA_integer_)

  expect_error(asInt("a"))
  expect_error(asInt(3+1i))
  expect_error(asInt(iris))
  expect_error(asInt(xi, lower = 2), ">=")
})

test_that("asCount", {
  xi = 1L
  xd = 1.
  xc = as.complex(1)

  expect_equal(names(asCount(xi)), names(xi))
  expect_equal(names(asCount(xd)), names(xd))
  expect_equal(names(asCount(xc)), names(xc))
  names(xi) = names(xd) = names(xc) = "a"
  expect_equal(names(asCount(xi)), names(xi))
  expect_equal(names(asCount(xd)), names(xd))
  expect_equal(names(asCount(xc)), names(xc))

  expect_error(asCount(1:2), "count")
  expect_equal(asCount(xi), xi)
  expect_equal(asCount(xd), xi)
  expect_equal(asCount(xc), xi)
  expect_error(asCount(NA), "NA")
  expect_equal(asCount(NA, na.ok = TRUE), NA_integer_)

  expect_error(asCount("a"))
  expect_error(asCount(3+1i))
  expect_error(asCount(iris))
  expect_error(asCount(0, positive = TRUE))
  expect_equal(asCount(1, positive = FALSE), 1L)
})
