context("checkNamed")

test_that("checkNamed", {
  expect_true(checkNamed(integer(0)))
  expect_true(checkNamed(NULL))
  expect_true(checkNamed(setNames(integer(0), character(0))))

  x = setNames(1:2, c("a", ".a"))
  expect_true(checkNamed(x))
  expect_true(checkNamed(x, "unique"))
  expect_true(checkNamed(x, "strict"))

  expect_false(checkNamed(1))
  expect_false(checkNamed(setNames(x, NA_character_)))
  expect_false(checkNamed(setNames(x, NA_integer_)))
  expect_false(checkNamed(setNames(x, "")))

  x = setNames(1:2, c("a", "a"))
  expect_true(checkNamed(x))
  expect_false(checkNamed(x, "unique"))

  x = setNames(1:2, c("a", "1"))
  expect_true(checkNamed(x))
  expect_false(checkNamed(x, "strict"))

  x = setNames(1:2, c("a", "..1"))
  expect_true(checkNamed(x))
  expect_false(checkNamed(x, "strict"))
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
