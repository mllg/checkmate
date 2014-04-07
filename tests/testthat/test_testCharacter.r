context("isCharacter")

test_that("isCharacter", {
  expect_true(isCharacter(character(0)))
  expect_false(isCharacter(NULL))
  expect_true(isCharacter("a"))
  expect_false(isCharacter(1))

  x = c("abba", "baab")
  expect_true(isCharacter(x, pattern="a"))
  expect_true(isCharacter(x, pattern="ab"))
  expect_false(isCharacter(x, pattern="aa"))
  expect_false(isCharacter(x, pattern="^ab"))
  expect_true(isCharacter(x, pattern="AB", ignore.case=TRUE))
  expect_false(isCharacter(x, pattern="AB", ignore.case=FALSE))

  x = letters[1:3]
  expect_true(isCharacter(x, na.ok=FALSE, min.len=1L, max.len=3L))
  expect_false(isCharacter(x, na.ok=FALSE, len=5))
})

test_that("assertString", {
  expect_true(assertCharacter(""))
  expect_error(assertCharacter(NA, "string"))
})
