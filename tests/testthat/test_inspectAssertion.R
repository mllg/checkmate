context("inspectAssertion")

test_that("inspectAssertion", {
  expect_inspect_result = function(x, expr) {
    res = inspectAssertion(expr)
    expect_true(is.list(res))
    expect_equal(names(res), c("message", "x"))
    expect_true(is.character(res$message) && length(res$message) == 1L)
    expect_identical(x, res$x)
  }

  expect_equal(inspectAssertion(assertNumeric(1:10)), 1:10)

  x = "a"
  expect_inspect_result(x, assertNumeric(x))
  expect_inspect_result(x, assertAtomicVector(x, min.len = 2))
  expect_inspect_result(x, qassert(x, "B1"))
})

test_that("x is not copied", {
  skip_if_not_installed("pryr")
  requireNamespace("pryr", quietly = TRUE)
  x1 = runif(100)
  x2 = tryCatch(assertNumeric(x1, lower = 2), assertion_error = function(e) e$attached)
  expect_true(identical(pryr::address(x1), pryr::address(x2)))
})
