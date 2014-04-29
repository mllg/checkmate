context("check_matrix")

test_that("check_matrix", {
  x = matrix(1:9, 3)
  expect_true(test(x, "matrix"))
  expect_true(test(matrix(nrow=0, ncol=0), "matrix"))
  expect_false(test(NULL, "matrix"))
  x[2,2] = NA
  expect_true(test(x, "matrix"))
  expect_false(test(x, "matrix", any.missing = FALSE))

  expect_true(test(x, "matrix", min.rows = 1, min.cols = 1))
  expect_true(test(x, "matrix", nrows = 3, ncols = 3))
  expect_false(test(x, "matrix", min.rows = 5))
  expect_false(test(x, "matrix", min.cols = 5))
  expect_false(test(x, "matrix", nrows = 5))
  expect_false(test(x, "matrix", ncols = 5))

  expect_false(test(x, "matrix", row.names = "named"))
  expect_false(test(x, "matrix", col.names = "named"))
  rownames(x) = colnames(x) = letters[1:3]
  expect_true(test(x, "matrix", row.names = "named"))
  expect_true(test(x, "matrix", col.names = "named"))

  expect_true(assert(x, "matrix"))
  expect_error(assert(iris, "matrix"), "matrix")
})
