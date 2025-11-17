context("makeXFunction")


test_that("makeAssertion", {
  x = assertFlag
  y = makeAssertionFunction(checkFlag, c.fun = "c_check_flag", use.namespace = FALSE)
  expect_identical(formals(x), formals(y))
  if (!isNamespaceLoaded("covr"))
    expect_equal(body(x), body(y))

  x = assertList
  y = makeAssertionFunction(checkList, use.namespace = FALSE)
  expect_identical(formals(x), formals(y))
  if (!isNamespaceLoaded("covr"))
    expect_equal(body(x), body(y))
})

test_that("makeTest", {
  x = testFlag
  y = makeTestFunction(checkFlag, c.fun = "c_check_flag")
  expect_identical(formals(x), formals(y))
  if (!isNamespaceLoaded("covr"))
    expect_equal(body(x), body(y))

  x = testList
  y = makeTestFunction(checkList)
  expect_identical(formals(x), formals(y))
  if (!isNamespaceLoaded("covr"))
    expect_equal(body(x), body(y))

  x = testFlag
  y = function(x) makeTest(checkFlag(x))
  expect_equal(x(TRUE), y(TRUE))
  expect_equal(x(FALSE), y(FALSE))
})

test_that("makeExpectation", {
  x = expect_flag
  y = makeExpectationFunction(checkFlag, c.fun = "c_check_flag", use.namespace = FALSE)
  expect_identical(formals(x), formals(y))
  if (!isNamespaceLoaded("covr"))
    expect_equal(body(x), body(y))

  x = expect_list
  y = makeExpectationFunction(checkList, use.namespace = FALSE)
  expect_identical(formals(x), formals(y))
  if (!isNamespaceLoaded("covr"))
    expect_equal(body(x), body(y))
})

test_that("makeX with name for 'x' not 'x'", {
  checker = function(foo, bar = FALSE) checkFlag(foo, na.ok = bar)

  achecker = makeAssertionFunction(checker)
  expect_identical(names(formals(achecker)), c("foo", "bar", ".var.name", "add"))
  expect_error(achecker(), 'argument "foo" is missing')
  expect_identical(achecker(FALSE), FALSE)
  expect_error(achecker(1L), "Assertion on '1L' failed")
  expect_error(achecker(NA), "May not be NA")
  expect_identical(achecker(NA, bar = TRUE), NA)
  expect_error(achecker(NA, bar = "x"), "'na.ok' must be a flag")

  tchecker = makeTestFunction(checker)
  expect_identical(names(formals(tchecker)), c("foo", "bar"))
  expect_error(tchecker(), 'argument "foo" is missing')
  expect_true(tchecker(FALSE))
  expect_false(tchecker(1L))
  expect_false(tchecker(NA))
  expect_true(tchecker(NA, bar = TRUE))
  expect_error(tchecker(NA, bar = "x"), "'na.ok' must be a flag")

  echecker = makeExpectationFunction(checker)
  expect_identical(names(formals(echecker)), c("foo", "bar", "info", "label"))
  expect_error(echecker(), 'argument "foo" is missing')
  expect_identical(echecker(FALSE), FALSE)
  expect_error(echecker(1L), "Check on '1L' failed")
  expect_error(echecker(NA), "May not be NA")
  expect_identical(echecker(NA, bar = TRUE), NA)
  expect_error(echecker(NA, bar = "x"), "'na.ok' must be a flag")
})

test_that("makeXFunction works with named args trailing `...`", {
  checker = function(object, ..., force.fail = FALSE) {
    if (isTRUE(force.fail)) return("Forced failure")
    TRUE
  }

  achecker = makeAssertionFunction(checker)
  expect_error(achecker(), 'argument "object" is missing')
  expect_identical(achecker("foo"), "foo")
  expect_error(achecker("foo", force.fail = TRUE), ".+foo.+Forced failure")

  tchecker = makeTestFunction(checker)
  expect_true(tchecker("foo"))
  expect_false(tchecker("foo", force.fail = TRUE))

  echecker = makeExpectationFunction(checker)
  expect_error(echecker(), 'argument "object" is missing')
  expect_identical(echecker("foo"), "foo")
  expect_error(echecker("foo", force.fail = TRUE), ".+foo.+Forced failure")
})
