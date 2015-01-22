context("checkNames")

test_that("checkNames", {
  nn = letters[1:3]
  expect_succ(Names, nn)
  expect_fail(Names, nn, type = "unnamed")

  expect_true(testNames(character(0)))
  expect_false(testNames(NULL))
  expect_false(testNames(integer(0)))

  x = c("a", ".a")
  expect_true(testNames(x))
  expect_true(testNames(x, "unique"))
  expect_true(testNames(x, "strict"))

  expect_false(testNames(1))
  expect_false(testNames(NA_character_))
  expect_false(testNames(NA_integer_))
  expect_false(testNames(""))

  x = c("a", "a")
  expect_true(testNames(x))
  expect_false(testNames(x, "unique"))

  expect_true(testNames("x", type = "strict"))
  expect_true(testNames("..x", type = "strict"))
  expect_true(testNames("x_1", type = "strict"))
  expect_true(testNames("x.", type = "strict"))
  expect_false(testNames("1", type = "strict"))
  expect_false(testNames(".1", type = "strict"))
  expect_false(testNames("..1", type = "strict"))
  expect_false(testNames("x ", type = "strict"))
  expect_false(testNames("ä", type = "strict"))
  expect_error(assertNames(c("a", "a"), "unique"), "unique")

  x = c("a", "1")
  expect_error(assertNames(x, "strict"), "naming rules")
})

test_that("argument 'type' is checked", {
  expect_error(checkNames("x", type = 1), "string")
  expect_error(checkNames("x", type = NA_character_), "missing")
})
