context("checkRaw")

test_that("checkRaw", {
  myobj = as.raw(1)
  expect_succ_all(Raw, myobj)
  myobj = 1
  expect_fail_all(Raw, myobj)

  expect_true(testRaw(as.raw(NULL)))
  expect_false(testRaw(NULL))
  expect_true(testRaw(as.raw(NULL), len = 0))
  expect_true(testRaw(as.raw(1), len = 1))
  expect_true(testRaw(as.raw(1), min.len = 1, max.len = 1))

  x = as.raw(1:2)
  names(x) = letters[1:2]

  expect_true(testRaw(x, names = "unique"))

  expect_error(assertRaw(1), "raw")
  expect_error(assertRaw(as.raw(1), len = 2), "length")
})
