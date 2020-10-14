context("checkComplex")

test_that("checkComplex", {
  myobj = 1+1i
  expect_succ_all(Complex, myobj)
  myobj = 1
  expect_fail_all(Complex, myobj)

  expect_true(testComplex(complex(0L)))
  expect_false(testComplex(NULL))
  expect_false(testComplex(TRUE))
  expect_true(testComplex(NA))
  expect_false(testComplex(NA, any.missing = FALSE))
  expect_false(testComplex(NA, all.missing = FALSE))
  expect_true(testComplex(NA_complex_))
  expect_true(testComplex(1+1i))
  expect_true(testComplex(as.complex(Inf)))
  expect_true(testComplex(c(1+1i, 2+1i), any.missing = FALSE, min.len = 1L, max.len = 3L))

  expect_error(assertComplex(1), "complex")
})

test_that("typed.missing", {
  expect_true(testComplex(NA))
  expect_true(testComplex(NA, typed.missing = FALSE))
  expect_false(testComplex(NA, typed.missing = TRUE))

  expect_true(testComplex(character()))
  expect_true(testComplex(character(), typed.missing = FALSE))
  expect_false(testComplex(character(), typed.missing = TRUE))
})
