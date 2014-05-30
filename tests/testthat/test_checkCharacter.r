context("checkCharacter")

test_that("checkCharacter", {
  expect_true(testCharacter(character(0)))
  expect_false(testCharacter(NULL))
  expect_true(testCharacter("a"))
  expect_false(testCharacter(1))
  expect_true(testCharacter(NA))
  expect_true(testCharacter(NA_character_))

  x = c("abba", "baab")
  expect_true(testCharacter(x, pattern="a"))
  expect_true(testCharacter(x, pattern="ab"))
  expect_false(testCharacter(x, pattern="aa"))
  expect_false(testCharacter(x, pattern="^ab"))
  expect_true(testCharacter(x, pattern="AB", ignore.case=TRUE))
  expect_true(testCharacter(x, pattern="AB", ignore.case=TRUE))
  expect_false(testCharacter(x, pattern="AB", ignore.case=FALSE))
  expect_false(testCharacter(x, pattern="AB", ignore.case=FALSE))

  x = letters[1:3]
  expect_true(testCharacter(x, any.missing=FALSE, min.len=1L, max.len=3L))
  expect_false(testCharacter(x, any.missing=FALSE, len=5))

  expect_true(assertCharacter(""))
  expect_error(assertCharacter(1), "character")
})
