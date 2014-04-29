context("check_string")

test_that("check_string", {
  expect_false(test(character(0), "string"))
  expect_false(test(NULL, "string"))
  expect_true(test("", "string"))
  expect_true(test("foo", "string"))
  expect_true(test(NA, "string", na.ok = TRUE))
  expect_false(test(NA_character_, "string"))
  expect_true(test(NA_character_, "string", na.ok = TRUE))
  expect_false(test(NA_character_, "string", all.missing = TRUE))
  expect_true(test(NA, "string", na.ok = TRUE))

  expect_true(assert("a", "string"))
  expect_error(assert(1, "string", "string"))
  expect_error(assert("a", "string", pattern="b"), "pattern")
  expect_error(assert("a", "string", min.chars=10), "at least 10")
})
