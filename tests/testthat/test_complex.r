context("check_complex")

test_that("check_compley", {
  expect_true(test(complex(0), "complex"))
  expect_false(test(NULL, "complex"))
  expect_false(test(TRUE, "complex"))
  expect_true(test(NA, "complex"))
  expect_false(test(NA, "complex", any.missing = FALSE))
  expect_false(test(NA, "complex", all.missing = FALSE))
  expect_true(test(NA_complex_, "complex"))
  expect_true(test(1+1i, "complex"))
  expect_true(test(as.complex(Inf), "complex"))
  expect_true(test(c(1+1i, 2+1i), "complex", any.missing=FALSE, min.len=1L, max.len=3L))

  expect_true(assert(1+1i, "complex"))
  expect_error(assert(1, "complex", "complex"))
})
