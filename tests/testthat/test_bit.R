context("checkBit")

test_that("checkBit", {
  skip_if_not_installed("bit")
  requireNamespace("bit")

  xl = c(TRUE, FALSE)
  xb = bit::as.bit(xl)
  expect_succ_all(Bit, xb)
  expect_fail_all(Bit, xl)

  expect_true(checkBit(xb, len = 2))
  expect_true(checkBit(xb, min.len = 2))
  expect_true(checkBit(xb, max.len = 2))
  expect_true(checkBit(xb, min.0 = 1))
  expect_true(checkBit(xb, min.1 = 1))

  expect_string(checkBit(xb, len = 1), fixed = "length")
  expect_string(checkBit(xb, min.len = 3), fixed = ">=")
  expect_string(checkBit(xb, max.len = 1), fixed = "<=")
  expect_string(checkBit(xb, min.0 = 2), fixed = "'0'")
  expect_string(checkBit(xb, min.1 = 2), fixed = "'1'")

  expect_error(checkBit(xb, len = NA), "missing")
  expect_error(checkBit(xb, min.len = NA), "missing")
  expect_error(checkBit(xb, max.len = NA), "missing")
  expect_error(checkBit(xb, min.0 = -1), ">=")
  expect_error(checkBit(xb, min.1 = NA), "missing")
})
