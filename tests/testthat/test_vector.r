context("check_vector")

test_that("check_vector", {
  expect_true(test(integer(0), "vector"))
  expect_false(test(NULL, "vector"))
  expect_true(test(1, "vector"))
  expect_true(test(integer(0), "vector"))

  expect_true(test(NA, "vector", na.ok=TRUE))
  expect_false(test(NA, "vector", na.ok=FALSE))

  expect_true(test(1, "vector", len=1))
  expect_false(test(1, "vector", len=0))

  expect_true(test(1, "vector", min.len=0))
  expect_false(test(1, "vector", min.len=2))
  expect_true(test(1, "vector", max.len=1))
  expect_false(test(1, "vector", max.len=0))


  expect_true(assert(1, "vector"))
  expect_error(assert(NA, "vector", "string"))
})
