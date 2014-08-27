context("checkNull")

test_that("checkNull", {
  myobj = NULL
  expect_succ(Null, myobj)
  myobj = TRUE
  expect_fail(Null, myobj)

  expect_false(testNull(integer(0)))
  expect_true(testNull(NULL))

  expect_error(assertNull(-1), "NULL")
})
