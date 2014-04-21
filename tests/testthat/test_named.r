context("check_named")

test_that("check_named", {
  expect_true(test(integer(0), "named"))
  expect_true(test(NULL, "named"))
  expect_true(test(setNames(integer(0), character(0)), "named"))

  x = setNames(1:2, c("a", ".a"))
  expect_true(test(x, "named"))
  expect_true(test(x, "named", "unique"))
  expect_true(test(x, "named", "strict"))

  expect_false(test(1, "named"))
  expect_false(test(setNames(x, NA_character_), "named"))
  expect_false(test(setNames(x, NA_integer_), "named"))
  expect_false(test(setNames(x, ""), "named"))

  x = setNames(1:2, c("a", "a"))
  expect_true(test(x, "named"))
  expect_false(test(x, "named", "unique"))

  x = setNames(1:2, c("a", "1"))
  expect_true(test(x, "named"))
  expect_false(test(x, "named", "strict"))

  x = setNames(1:2, c("a", "..1"))
  expect_true(test(x, "named"))
  expect_false(test(x, "named", "strict"))


  x = setNames(1:2, c("a", ".a"))
  expect_true(assert(x, "named"))

  x = setNames(1, "")
  expect_error(assert(x, "named"), "named")

  x = setNames(1:2, c("a", "a"))
  expect_error(assert(x, "named", "unique"), "duplicated")

  x = setNames(1:2, c("a", "1"))
  expect_error(assert(x, "named", "strict"), "naming rules")
})
