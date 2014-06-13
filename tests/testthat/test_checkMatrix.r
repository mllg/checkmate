context("checkMatrix")

test_that("checkMatrix", {
  x = matrix(1:9, 3)
  expect_true(testMatrix(x))
  expect_true(testMatrix(matrix(nrow=0, ncol=0)))
  expect_false(testMatrix(NULL))
  x[2,2] = NA
  expect_true(testMatrix(x))
  expect_false(testMatrix(x, any.missing = FALSE))

  expect_true(testMatrix(x, min.rows = 1, min.cols = 1))
  expect_true(testMatrix(x, nrows = 3, ncols = 3))
  expect_false(testMatrix(x, min.rows = 5))
  expect_false(testMatrix(x, min.cols = 5))
  expect_false(testMatrix(x, nrows = 5))
  expect_false(testMatrix(x, ncols = 5))

  expect_false(testMatrix(x, row.names = "named"))
  expect_false(testMatrix(x, col.names = "named"))
  rownames(x) = colnames(x) = letters[1:3]
  expect_true(testMatrix(x, row.names = "named"))
  expect_true(testMatrix(x, col.names = "named"))

  expect_true(testMatrix(x, mode = "integer"))
  expect_true(testMatrix(x, mode = "numeric"))
  expect_false(testMatrix(x, mode = "double"))

  expect_true(assertMatrix(x))
  expect_error(assertMatrix(iris))
})
