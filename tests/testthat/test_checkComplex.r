context("checkComplex")

test_that("checkCompley", {
  expect_true(testComplex(complex(0)))
  expect_false(testComplex(NULL))
  expect_false(testComplex(TRUE))
  expect_true(testComplex(NA))
  expect_false(testComplex(NA, any.missing = FALSE))
  expect_false(testComplex(NA, all.missing = FALSE))
  expect_true(testComplex(NA_complex_))
  expect_true(testComplex(1+1i))
  expect_true(testComplex(as.complex(Inf)))
  expect_true(testComplex(c(1+1i, 2+1i), any.missing=FALSE, min.len=1L, max.len=3L))

  expect_true(assertComplex(1+1i))
  expect_error(assertComplex(1))
})
