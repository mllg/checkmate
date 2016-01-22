context("registered c functions")

test_that("include of registered C functions works", {
  requireNamespace("devtools")

  devtools::load_all("checkmate.test.include", recompile = TRUE,
    export_all = FALSE, quiet = TRUE)

  expect_true(reexported_qtest(1, "N1"))
  expect_false(reexported_qtest(1, "b"))

  x = pi
  expect_identical(reexported_qassert(x, "N1"), x)
  expect_error(reexported_qassert(x, "b", "foo"), "foo")
  devtools::clean_dll("checkmate.test.include")
})
