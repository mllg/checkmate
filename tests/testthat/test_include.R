context("registered c functions")

test_that("include of registered C functions works", {
  skip_on_travis()
  skip_on_cran()
  devtools::install_github("mllg/checkmate-test-include")
  library(checkmate.test.include)

  expect_true(reexported_qtest(1, "N1"))
  expect_false(reexported_qtest(1, "b"))

  x = pi
  expect_identical(reexported_qassert(x, "N1"), x)
  expect_error(reexported_qassert(x, "b", "foo"), "foo")
})
