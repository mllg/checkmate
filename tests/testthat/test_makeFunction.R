context("makeXFunction")

test_that("makeAssertion", {
  x = assertFlag
  y = makeAssertionFunction(checkFlag, c.fun = "c_check_flag")
  expect_identical(formals(x), formals(y))
  expect_equal(body(x), body(y))

  x = assertList
  y = makeAssertionFunction(checkList)
  expect_identical(formals(x), formals(y))
  expect_equal(body(x), body(y))
})

test_that("makeTest", {
  x = testFlag
  y = makeTestFunction(checkFlag, c.fun = "c_check_flag")
  expect_identical(formals(x), formals(y))
  expect_equal(body(x), body(y))

  x = testList
  y = makeTestFunction(checkList)
  expect_identical(formals(x), formals(y))
  expect_equal(body(x), body(y))

  x = testFlag
  y = function(x) makeTest(checkFlag(x))
  expect_equal(x(TRUE), y(TRUE))
  expect_equal(x(FALSE), y(FALSE))
})

test_that("makeExpectation", {
  x = expect_flag
  y = makeExpectationFunction(checkFlag, c.fun = "c_check_flag")
  expect_identical(formals(x), formals(y))
  expect_equal(body(x), body(y))

  x = expect_list
  y = makeExpectationFunction(checkList)
  expect_identical(formals(x), formals(y))
  expect_equal(body(x), body(y))
})
