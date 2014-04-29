context("check_inconstant")

test_that("check_inconstant", {
  expect_false(test(rep(NA, 2), "inconstant"))
  expect_false(test(c(1-0.9-0.1, 0), "inconstant"))
  expect_false(test(c(), "inconstant"))
  expect_false(test(rep(NA, 5), "inconstant"))
  expect_false(test(list(iris), "inconstant"))
  expect_false(test(list(iris, iris), "inconstant"))
  expect_false(test(c(1+1i, 1+1i), "inconstant"))

  expect_true(test(1:2, "inconstant"))
  expect_true(test(c(1, NA), "inconstant"))
  expect_true(test(c(TRUE, NA), "inconstant"))
  expect_true(test(c(TRUE, NA), "inconstant"))
  expect_true(test(c(1+1i, 1+1.5i), "inconstant"))
  expect_true(test(list(1, 1, 1L), "inconstant"))


  expect_true(assert(1, "constant"))
  expect_error(assert(1:2, "constant"), "constant")
  expect_true(assert(1:2, "inconstant"))
  expect_error(assert(1, "inconstant"), "inconstant")
})
