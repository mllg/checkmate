context("check_vector")

test_that("check_vector", {
  expect_true(test(integer(0), "vector"))
  expect_false(test(NULL, "vector"))
  expect_true(test(1, "vector"))
  expect_true(test(integer(0), "vector"))

  expect_true(test(NA, "vector", any.missing = TRUE))
  expect_false(test(NA, "vector", any.missing = FALSE))
  expect_false(test(NA, "vector", all.missing = FALSE))

  expect_true(test(1, "vector", len=1))
  expect_false(test(1, "vector", len=0))

  expect_true(test(1, "vector", min.len=0))
  expect_false(test(1, "vector", min.len=2))
  expect_true(test(1, "vector", max.len=1))
  expect_false(test(1, "vector", max.len=0))

  expect_true(test(1, "vector", unique=TRUE))
  expect_false(test(1, "vector", min.len=2))
  expect_true(test(1, "vector", max.len=1))
  expect_false(test(1, "vector", max.len=0))

  expect_true(test(1, "vector", unique=TRUE))
  expect_true(test(c(1,1), "vector", unique=FALSE))
  expect_false(test(c(1,1), "vector", unique=TRUE))

  expect_true(test(1, "vector", names="unnamed"))
  expect_true(test(setNames(1, "x"), "vector", names="named"))
  expect_false(test(1, "vector", names="unique"))

  expect_true(assert(1, "vector"))
  expect_error(assert(NA, "vector", "string"))
})
