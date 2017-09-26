context("checkBit")

test_that("checkBit", {
  skip_if_not_physically_installed("bit")

  expect_false(testBit(FALSE))
  expect_true("bit" %in% loadedNamespaces())

  xl = c(TRUE, FALSE)
  xb = bit::as.bit(xl)
  expect_succ_all(Bit, xb)
  expect_fail_all(Bit, xl)

  expect_true(checkBit(xb, len = 2))
  expect_true(checkBit(xb, min.len = 2))
  expect_true(checkBit(xb, max.len = 2))
  expect_true(checkBit(xb, min.0 = 1))
  expect_true(checkBit(xb, min.1 = 1))

  expect_error(assertBit(xb, len = 1), regexp = "length")
  expect_error(assertBit(xb, min.len = 3), regexp = ">=")
  expect_error(assertBit(xb, max.len = 1), regexp = "<=")
  expect_error(assertBit(xb, min.0 = 2), regexp = "'0'")
  expect_error(assertBit(xb, min.1 = 2), regexp = "'1'")
  expect_error(assertBit(xb, min.1 = 2), regexp = "has 1")

  expect_error(checkBit(xb, len = NA), "missing")
  expect_error(checkBit(xb, min.len = NA), "missing")
  expect_error(checkBit(xb, max.len = NA), "missing")
  expect_error(checkBit(xb, min.0 = -1), ">=")
  expect_error(checkBit(xb, min.1 = NA), "missing")
})
