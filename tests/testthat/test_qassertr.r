context("qtestr")

expect_succ_all = function(x, rules) {
  expect_true(qtestr(x, rules),
    info=sprintf("vector %s, rules: %s", deparse(substitute(x)), paste(rules, collapse=",")))
  expect_identical(qassertr(x, rules), x,
    info=sprintf("vector %s, rules: %s", deparse(substitute(x)), paste(rules, collapse=",")))
  expect_true(is.expectation(qexpectr(x, rules)),
    info=sprintf("vector %s, rules: %s", deparse(substitute(x)), paste(rules, collapse=",")))
}

expect_fail_all = function(x, rules) {
  expect_false(qtestr(x, rules),
    info=sprintf("vector %s, rules: %s", deparse(substitute(x)), paste(rules, collapse=",")))
  expect_true(inherits(try(qassertr(x, rules), silent=TRUE), "try-error"),
    info=sprintf("vector %s, rules: %s", deparse(substitute(x)), paste(rules, collapse=",")))
  expect_error(with_reporter(SilentReporter(), qexpectr(x, rules)),
    info=sprintf("vector %s, rules: %s", deparse(substitute(x)), paste(rules, collapse=",")))
}

test_that("qassertr / qtestr", {
  x = list(a=1:10, b=rnorm(10))
  expect_succ_all(x, "n+")
  expect_succ_all(x, "n10")
  expect_succ_all(x, "n>=1")
  expect_fail_all(x, "i+")
  expect_fail_all(x, "l")

  x = list(a = NULL, b = 10)
  expect_succ_all(x, "*")
  expect_fail_all(x, "0")
  expect_fail_all(x, "n")

  x = list(a = NULL, b = NULL)
  expect_succ_all(x, "0")
  expect_fail_all(x, "0+")

  x = list()
  expect_succ_all(x, "n+")
  expect_succ_all(x, "0+")

  x = list(1, 2)
  expect_fail_all(x, "S1")

  x = NULL
  expect_error(qassertr(x, "x"), "list or data.frame")
  expect_error(qtestr(x, "x"), "list or data.frame")
})
