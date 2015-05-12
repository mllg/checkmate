context("checkArray")

test_that("checkArray", {
  myobj = array(1:2)
  expect_succ(Array, myobj)
  myobj = 1:2
  expect_fail(Array, myobj)

  x = array(dim = c(2, 3))
  expect_true(testArray(x))
  expect_true(testArray(x, d = 2L))
  expect_false(testArray(x, d = 1L))
  expect_true(testArray(x, min.d = 0L))
  expect_true(testArray(x, min.d = 1L))
  expect_true(testArray(x, max.d = 2L))
  expect_true(testArray(x, max.d = 3L))
  expect_false(testArray(x, min.d = 3L))
  expect_false(testArray(x, max.d = 1L))

  x[2,2] = NA
  expect_true(testMatrix(x))
  expect_false(testMatrix(x, any.missing = FALSE))
  expect_false(testArray(x, any.missing = FALSE))
  expect_error(assertArray(iris))

  x = array(1:27, dim = c(3, 3, 3))
  expect_true(testArray(x, mode = "integer"))
  expect_true(testArray(x, mode = "numeric"))
  expect_true(testArray(x, mode = "atomic"))
  expect_false(testArray(x, mode = "double"))
  expect_false(testArray(x, mode = "character"))
  expect_false(testArray(x, mode = "list"))

  x = array(list(1, 1), dim = c(1, 2))
  expect_true(testArray(x))
  expect_true(testArray(x, mode = "list"))
  expect_false(testArray(x, mode = "atomic"))
  expect_false(testArray(x, mode = "numeric"))

  expect_error(assertArray(1:3), "array")
})

test_that("type guessing works", {
  x = array(1:4)
  expect_match(checkCharacter(x), "array")

  x = array(1:4, dim = c(2, 2))
  expect_match(checkCharacter(x), "matrix")

  x = array(1:9, dim = c(3, 3, 3))
  expect_match(checkCharacter(x), "array")
})
