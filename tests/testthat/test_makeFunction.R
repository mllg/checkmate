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
  checker = function(foo, bar = TRUE) check_numeric(foo)

  achecker = makeAssertionFunction(checker)
  expect_identical(names(formals(achecker)), c("foo", "bar", ".var.name", "add"))
  expect_identical(as.character(formals(achecker)$.var.name)[2], "foo")
  expect_equal(sum(grepl("foo", as.character(body(achecker)))), 3L)
  expect_equal(sum(grepl("bar", as.character(body(achecker)))), 1L)

  tchecker = makeTestFunction(checker)
  expect_identical(names(formals(tchecker)), c("foo", "bar"))
  expect_equal(sum(grepl("foo", as.character(body(tchecker)))), 1L)
  expect_equal(sum(grepl("bar", as.character(body(tchecker)))), 1L)

  echecker = makeExpectationFunction(checker)
  expect_identical(names(formals(echecker)), c("foo", "bar", "info", "label"))
  expect_equal(sum(grepl("foo", as.character(body(echecker)))), 3L)
  expect_equal(sum(grepl("bar", as.character(body(echecker)))), 1L)
})
