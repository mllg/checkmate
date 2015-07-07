context("checkString")

test_that("checkString", {
  myobj = "a"
  expect_succ_all(String, myobj)
  myobj = 1L
  expect_fail_all(String, myobj)

  expect_false(testString(character(0)))
  expect_false(testString(NULL))
  expect_true(testString(""))
  expect_true(testString("foo"))
  expect_true(testString(NA, na.ok = TRUE))
  expect_false(testString(NA_character_))
  expect_true(testString(NA_character_, na.ok = TRUE))
  expect_true(testString(NA, na.ok = TRUE))

  expect_error(assertString(1))
})
