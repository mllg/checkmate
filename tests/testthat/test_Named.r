context("isNamed")

test_that("isNamed", {
  expect_true(isNamed(integer(0)))
  expect_true(isNamed(NULL))
  expect_true(isNamed(setNames(integer(0), character(0))))

  x = setNames(1:2, c("a", ".a"))
  expect_true(isNamed(x))
  expect_true(isNamed(x, "unique"))
  expect_true(isNamed(x, "strict"))

  expect_false(isNamed(1))
  expect_false(isNamed(setNames(x, NA_character_)))
  expect_false(isNamed(setNames(x, NA_integer_)))
  expect_false(isNamed(setNames(x, "")))

  x = setNames(1:2, c("a", "a"))
  expect_true(isNamed(x))
  expect_false(isNamed(x, "unique"))

  x = setNames(1:2, c("a", "1"))
  expect_true(isNamed(x))
  expect_false(isNamed(x, "strict"))

  x = setNames(1:2, c("a", "..1"))
  expect_true(isNamed(x))
  expect_false(isNamed(x, "strict"))
})

test_that("assertNamed", {
  x = setNames(1:2, c("a", ".a"))
  expect_true(assertNamed(x))

  x = setNames(1, "")
  expect_error(assertNamed(x), "named")

  x = setNames(1:2, c("a", "a"))
  expect_error(assertNamed(x, "unique"), "duplicated")

  x = setNames(1:2, c("a", "1"))
  expect_error(assertNamed(x, "strict"), "naming rules")
})
