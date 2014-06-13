context("checkNull")

test_that("checkNull", {
  expect_false(testNull(integer(0)))
  expect_true(testNull(NULL))

  expect_error(assertNull(-1), "NULL")
})
