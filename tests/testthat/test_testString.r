context("isString")

test_that("isString", {
  expect_true(isString(character(0)))
  expect_false(isString(NULL))
  expect_true(isString("a"))
  expect_false(isString(1))

  x = c("abba", "baab")
  expect_true(isString(x, pattern="a"))
  expect_true(isString(x, pattern="ab"))
  expect_false(isString(x, pattern="aa"))
  expect_false(isString(x, pattern="^ab"))
  expect_true(isString(x, pattern="AB", ignore.case=TRUE))
  expect_false(isString(x, pattern="AB", ignore.case=FALSE))

  x = letters[1:3]
  expect_true(isString(x, na.ok=FALSE, min.len=1L, max.len=3L))
  expect_false(isString(x, na.ok=FALSE, len=5))
})

test_that("assertString", {
  expect_true(assertString(""))
  expect_error(assertString(NA, "string"))
})
