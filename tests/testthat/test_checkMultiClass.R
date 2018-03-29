context("checkMultiClass")

test_that("checkMultiClass", {
  myobj = 1
  expect_succ_all(MultiClass, myobj, "numeric", cc = "MultiClass", lc = "multi_class")
  expect_fail_all(MultiClass, myobj, "integer")

  foo = 1
  class(foo) = c("a", "b")
  expect_true(testMultiClass(foo, "a"))
  expect_true(testMultiClass(foo, "b"))
  expect_false(testClass(foo, "c"))
  expect_true(testMultiClass(foo, c("c", "b")))
})
