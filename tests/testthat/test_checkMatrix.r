context("checkMatrix")

test_that("checkMatrix", {
  myobj = matrix(1:9, 3)
  expect_succ(Matrix, myobj)
  myobj = TRUE
  expect_fail(Matrix, myobj)

  x = matrix(1:9, 3)
  expect_true(testMatrix(x))
  expect_true(testMatrix(matrix(nrow=0, ncol=0)))
  expect_false(testMatrix(NULL))
  x[2,2] = NA
  expect_true(testMatrix(x))
  expect_false(testMatrix(x, any.missing = FALSE))

  xl = matrix(TRUE)
  xi = matrix(1L)
  xr = matrix(1.)
  xs = matrix("a")
  xc = matrix(1+1i)
  expect_true(testMatrix(xl, "logical"))
  expect_true(testMatrix(xi, "integer"))
  expect_true(testMatrix(xr, "double"))
  expect_true(testMatrix(xr, "numeric"))
  expect_true(testMatrix(xc, "complex"))
  expect_true(testMatrix(xs, "character"))
  expect_false(testMatrix(xs, "logical"))
  expect_false(testMatrix(xs, "integer"))
  expect_false(testMatrix(xs, "double"))
  expect_false(testMatrix(xs, "numeric"))
  expect_false(testMatrix(xs, "complex"))
  expect_false(testMatrix(xl, "character"))

  expect_true(testMatrix(x, min.rows = 1, min.cols = 1))
  expect_true(testMatrix(x, nrows = 3, ncols = 3))
  expect_false(testMatrix(x, min.rows = 5))
  expect_false(testMatrix(x, min.cols = 5))
  expect_false(testMatrix(x, nrows = 5))
  expect_false(testMatrix(x, ncols = 5))

  expect_false(testMatrix(x, row.names = "named"))
  expect_false(testMatrix(x, col.names = "named"))
  rownames(x) = letters[1:3]; colnames(x) = NULL
  expect_true(testMatrix(x, row.names = "named"))
  expect_false(testMatrix(x, col.names = "named"))
  colnames(x) = letters[1:3]; rownames(x) = NULL
  expect_false(testMatrix(x, row.names = "named"))
  expect_true(testMatrix(x, col.names = "named"))
  colnames(x) = rownames(x) = letters[1:3]
  expect_true(testMatrix(x, row.names = "named"))
  expect_true(testMatrix(x, col.names = "named"))

  expect_true(testMatrix(x, mode = "integer"))
  expect_true(testMatrix(x, mode = "numeric"))
  expect_false(testMatrix(x, mode = "double"))

  expect_error(assertMatrix(iris), "matrix")

  expect_true(testMatrix(matrix(ncol = 0, nrow = 0), row.names = "named"))
  expect_true(testMatrix(matrix(ncol = 0, nrow = 0), col.names = "named"))

  expect_error(assertMatrix(matrix(), min.len = 99), "99")
})

test_that("dimension arugments are checked", {
  x = matrix(1)
  expect_error(checkMatrix(x, min.rows = 1.2), "count")
  expect_error(checkMatrix(x, min.rows = NA_integer_), "missing")
  expect_error(checkMatrix(x, min.rows = -1), ">= 0")
})

test_that("dimesions are reported correctly", {
  x = matrix(1:42, ncol = 1)
  expect_true(grepl(42, checkMatrix(x, nrows = 43)))
  expect_true(grepl(42, checkMatrix(x, min.rows = 43)))

  x = t(x)
  expect_true(grepl(42, checkMatrix(x, ncols = 43)))
  expect_true(grepl(42, checkMatrix(x, min.cols = 43)))
})
