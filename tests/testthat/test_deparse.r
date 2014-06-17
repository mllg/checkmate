context("deparse")

test_that("deparse", {
  f = function(num, na.ok) {
    assertNumber(num)
    qassert(na.ok, "B1")
  }

  expect_true(f(1, TRUE))
  expect_error(f(NULL, TRUE), "num")
  expect_error(f(1, NULL), "na.ok")
})
