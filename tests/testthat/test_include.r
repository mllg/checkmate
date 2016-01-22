context("registered c functions")

test_that("include of registered C functions works", {
  requireNamespace("devtools")

  devtools::load_all("checkmate.test.include")

  expect_true(reexported_qtest(1, "N1"))
  expect_false(reexported_qtest(1, "b"))

  x = 1
  expect_identical(reexported_qassert(1, "N1"), x)
  expect_error(reexported_qassert(1, "b", "foo"), "foo")
})
