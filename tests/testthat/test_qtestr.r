context("qtestr")

expect_succ = function(x, rules) {
  expect_true(qtestr(x, rules),
    info=sprintf("vector %s, rules: %s", deparse(substitute(x)), paste(rules, collapse=",")))
  expect_true(qassertr(x, rules),
    info=sprintf("vector %s, rules: %s", deparse(substitute(x)), paste(rules, collapse=",")))
}

expect_fail = function(x, rules) {
  expect_false(qtestr(x, rules),
    info=sprintf("vector %s, rules: %s", deparse(substitute(x)), paste(rules, collapse=",")))
  expect_true(inherits(try(qassertr(x, rules), silent=TRUE), "try-error"),
    info=sprintf("vector %s, rules: %s", deparse(substitute(x)), paste(rules, collapse=",")))
}

test_that("qtestr", {
  x = list(a=1:10, b=rnorm(10))
  expect_succ(x, "n+")
  expect_succ(x, "n10")
  expect_succ(x, "n>=1")
  expect_fail(x, "i+")
  expect_fail(x, "l")

  x = list(a = NULL, b = 10)
  expect_succ(x, "*")
  expect_fail(x, "0")
  expect_fail(x, "n")

  x = list(a = NULL, b = NULL)
  expect_succ(x, "0")
  expect_fail(x, "0+")

  x = list()
  expect_succ(x, "n+")
  expect_succ(x, "0+")
})
