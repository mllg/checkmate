context("checkString")

test_that("checkString", {
  expect_true(checkString(character(0)))
  expect_false(checkString(NULL))
  expect_true(checkString("a"))
  expect_false(checkString(1))

  x = c("abba", "baab")
  expect_true(checkString(x, pattern="a"))
  expect_true(checkString(x, pattern="ab"))
  expect_false(checkString(x, pattern="aa"))
  expect_false(checkString(x, pattern="^ab"))
  expect_true(checkString(x, pattern="AB", ignore.case=TRUE))
  expect_false(checkString(x, pattern="AB", ignore.case=FALSE))

  x = letters[1:3]
  expect_true(checkString(x, na.ok=FALSE, min.len=1L, max.len=3L))
  expect_false(checkString(x, na.ok=FALSE, len=5))
})

test_that("assertString", {
  expect_true(assertString(""))
  expect_error(assertString(NA, "string"))
})
