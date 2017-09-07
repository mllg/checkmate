context("checkNamed")

test_that("checkNamed", {
  # checkNamed is deprecated. Skip tests on all platforms except local.
  skip_on_cran()
  skip_on_travis()
  skip_on_appveyor()

  myobj = setNames(1:3, letters[1:3])
  expect_succ_all(Named, myobj)
  myobj = 1:3
  expect_fail_all(Named, myobj)

  expect_true(testNamed(integer(0)))
  expect_true(testNamed(NULL))
  expect_true(testNamed(setNames(integer(0), character(0))))

  x = setNames(1:2, c("a", ".a"))
  expect_true(testNamed(x))
  expect_true(testNamed(x, "unique"))
  expect_true(testNamed(x, "strict"))

  expect_false(testNamed(1))
  expect_false(testNamed(setNames(x, NA_character_)))
  expect_false(testNamed(setNames(x, NA_integer_)))
  expect_false(testNamed(setNames(x, "")))

  x = setNames(1:2, c("a", "a"))
  expect_true(testNamed(x))
  expect_false(testNamed(x, "unique"))

  x = setNames(1:2, c("a", "1"))
  expect_true(testNamed(x))
  expect_false(testNamed(x, "strict"))

  x = setNames(1:2, c("a", "..1"))
  expect_true(testNamed(x))
  expect_false(testNamed(x, "strict"))


  x = setNames(1, "")
  expect_error(assertNamed(x), "named")

  x = setNames(1:2, c("a", "a"))
  expect_error(assertNamed(x, "unique"), "uniquely")

  expect_true(testNamed(setNames(1, "x"), type = "strict"))
  expect_true(testNamed(setNames(1, "..x"), type = "strict"))
  expect_true(testNamed(setNames(1, "x_1"), type = "strict"))
  expect_true(testNamed(setNames(1, "x."), type = "strict"))
  expect_false(testNamed(setNames(1, "1"), type = "strict"))
  expect_false(testNamed(setNames(1, ".1"), type = "strict"))
  expect_false(testNamed(setNames(1, "..1"), type = "strict"))
  expect_false(testNamed(setNames(1, "x "), type = "strict"))
  expect_false(testNamed(setNames(1, "ä"), type = "strict"))
  expect_error(assertNamed(x, "unique"), "uniquely")

  x = setNames(1:2, c("a", "1"))
  expect_error(assertNamed(x, "strict"), "naming conventions")
})
