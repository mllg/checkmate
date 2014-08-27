context("checkFlag")

test_that("checkFlag", {
  myobj = TRUE
  expect_succ(Flag, myobj)
  myobj = NA
  expect_fail(Flag, myobj)

  expect_false(testFlag(logical(0)))
  expect_false(testFlag(NULL))
  expect_true(testFlag(TRUE))
  expect_true(testFlag(FALSE))
  expect_false(testFlag(NA))
  expect_true(testFlag(NA, na.ok = TRUE))
  expect_true(testFlag(NA_character_, na.ok = TRUE))
  expect_false(testFlag(iris))

  expect_error(assertFlag(1), "logical flag")
})
