context("checkR6")

test_that("checkR6", {
  skip_if_not_physically_installed("R6")

  expect_false(testR6(1))
  expect_true("R6" %in% loadedNamespaces())

  x = R6::R6Class("Bar",
    public = list(a = 5),
    private = list(b = 42),
    active = list(c = function() 99)
    )$new()

  y = list(a = 5, b = 42)
  class(y) = "Bar"

  z = R6::R6Class("Bar", cloneable = FALSE)$new()

  expect_succ_all(R6, x)
  expect_fail_all(R6, y)

  expect_true(checkR6(NULL, null.ok = TRUE))
  expect_true(checkR6(x, "Bar", ordered = TRUE))
  expect_true(checkR6(x, cloneable = TRUE))
  expect_true(checkR6(z, cloneable = FALSE))
  expect_true(checkR6(x, public = character(0)))
  expect_true(checkR6(x, public = "a"))
  expect_true(checkR6(x, public = "c"))
  expect_true(checkR6(x, private = "b"))

  expect_error(assertR6(NULL, null.ok = FALSE), "NULL")
  expect_error(assertR6(x, cloneable = FALSE), "cloneable")
  expect_error(assertR6(z, cloneable = TRUE), "cloneable")
  expect_error(assertR6(x, public = "b"), "public")
  expect_error(assertR6(x, private = "a"), "private")
  expect_error(assertR6(x, private = "c"), "private")
})
