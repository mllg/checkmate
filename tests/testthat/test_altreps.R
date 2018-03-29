context("ALTREPS")

test_that("ALTREP no na", {
  skip_if(getRversion() < "3.5.0")
  wrapper = function(x, srt = 0, nna = 0) .Internal(wrap_meta(x, srt, nna))

  x = c(1, NA, 3)
  xw = wrapper(x, nna = 1)
  expect_true(anyMissing(x))
  expect_false(anyMissing(xw))

  x = as.integer(c(1, NA, 3))
  xw = wrapper(x, nna = 1)
  expect_true(anyMissing(x))
  expect_false(anyMissing(xw))

  x = c("a", NA, "b")
  xw = wrapper(x, nna = 1)
  expect_true(anyMissing(x))
  expect_false(anyMissing(xw))
})

test_that("ALTREP sorted", {
  skip_if(getRversion() < "3.5.0")
  wrapper = function(x, srt = 0, nna = 0) .Internal(wrap_meta(x, srt, nna))

  x = c(3, 1, 2)
  xw = wrapper(x, srt = 1)
  expect_false(testNumeric(x, sorted = TRUE))
  expect_true(testNumeric(xw, sorted = TRUE))

  x = as.integer(c(3, 1, 2))
  xw = wrapper(x, srt = 1)
  expect_false(testInteger(x, sorted = TRUE))
  expect_true(testInteger(xw, sorted = TRUE))

  x = c("c", "a", "b")
  xw = wrapper(x, srt = 1)
  expect_false(testCharacter(x, sorted = TRUE))
  expect_true(testCharacter(xw, sorted = TRUE))
})
