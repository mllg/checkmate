context("checkNamed")

test_that("checkNamed", {
  x = setNames(1:2, c("a", ".a"))
  expect_true(checkNamed(x))
  expect_true(checkNamed(x, dups.ok=FALSE))
  expect_true(checkNamed(x, dups.ok=FALSE, strict=TRUE))

  expect_false(checkNamed(1))
  expect_false(checkNamed(setNames(x, NA_character_)))
  expect_false(checkNamed(setNames(x, NA_integer_)))
  expect_false(checkNamed(setNames(x, "")))

  x = setNames(1:2, c("a", "a"))
  expect_true(checkNamed(x))
  expect_false(checkNamed(x, dups.ok=FALSE))

  x = setNames(1:2, c("a", "1"))
  expect_true(checkNamed(x))
  expect_false(checkNamed(x, strict=TRUE))

  x = setNames(1:2, c("a", "..1"))
  expect_true(checkNamed(x))
  expect_false(checkNamed(x, strict=TRUE))
})

test_that("assertInherits", {
  x = setNames(1:2, c("a", ".a"))
  expect_true(assertNamed(x))

  x = setNames(1, "")
  expect_error(assertNamed(x), "named")

  x = setNames(1:2, c("a", "a"))
  expect_error(assertNamed(x, dups.ok=FALSE), "duplicated")

  x = setNames(1:2, c("a", "1"))
  expect_error(assertNamed(x, strict=TRUE), "naming rules")
})
