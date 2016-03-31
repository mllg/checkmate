context("qtestr")

expect_succ_all = function(x, rules) {
  expect_true(qtestr(x, rules),
    info=sprintf("vector %s, rules: %s", deparse(substitute(x)), paste(rules, collapse=",")))
  expect_identical(qassertr(x, rules), x,
    info=sprintf("vector %s, rules: %s", deparse(substitute(x)), paste(rules, collapse=",")))
  expect_expectation_successful(qexpectr(x, rules))
}

expect_fail_all = function(x, rules, pattern = NULL) {
  expect_false(qtestr(x, rules),
    info=sprintf("vector %s, rules: %s", deparse(substitute(x)), paste(rules, collapse=",")))
  res = try(qassertr(x, rules), silent = TRUE)
  expect_true(inherits(res, "try-error"), info=sprintf("vector %s, rules: %s", deparse(substitute(x)), paste(rules, collapse=",")))
  if (!is.null(pattern))
    expect_true(grepl(x = as.character(res), pattern = pattern), info=sprintf("vector %s, rules: %s", deparse(substitute(x)), paste(rules, collapse=",")))
  expect_expectation_failed(qexpectr(x, rules))
}

test_that("qassertr / qtestr", {
  x = list(a = 1:10, b = rnorm(10))
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
  expect_fail_all(x, "S1", pattern = "string")

  x = list(1:10, NULL)
  expect_succ_all(x, c("v", "l", "0"))
  rules = c("v", "l")
  expect_fail_all(x, c("v", "l"), pattern = "One of")

  x = NULL
  expect_error(qassertr(x, "x"), "list or data.frame")
  expect_error(qtestr(x, "x"), "list or data.frame")
})
