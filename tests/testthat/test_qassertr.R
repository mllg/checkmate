context("qtestr")

expect_succ_all = function(x, rules) {
  xn = deparse(substitute(x))
  expect_true(qtestr(x, rules),
    info = sprintf("rules: %s", paste0(rules, collapse=",")), label = xn)
  expect_identical(qassertr(x, rules), x,
    info = sprintf("rules: %s", paste0(rules, collapse=",")), label = xn)
  expect_expectation_successful(qexpectr(x, rules),
    info = sprintf("rules: %s", paste0(rules, collapse=",")), label = xn)
}

expect_fail_all = function(x, rules, pattern = NULL) {
  xn = deparse(substitute(x))
  expect_false(qtestr(x, rules),
    info = sprintf("rules: %s", paste0(rules, collapse=",")), label = xn)
  expect_error(qassertr(x, rules), regex = pattern,
    info = sprintf("rules: %s", paste0(rules, collapse=",")), label = xn)
  expect_expectation_failed(qexpectr(x, rules),
    info = sprintf("rules: %s", paste0(rules, collapse=",")), label = xn)
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

  expect_succ_all(iris, c("f", "n"))
  expect_fail_all(iris, c("s", "n"), pattern = "One of")

  x = NULL
  expect_error(qassertr(x, "x"), "list or data.frame")
  expect_error(qtestr(x, "x"), "list or data.frame")
})

test_that("qtestr / depth", {
  x = list(letters, 1:10, list(letters, 2:3, runif(10)))
  rules = c("v", "l")
  expect_true(qtestr(x, rules, depth = 1L))
  expect_true(qtestr(x, rules, depth = 2L))
  expect_true(qtestr(x, rules, depth = 3L))

  x[[3]][[2]] = iris
  expect_true(qtestr(x, rules, depth = 1L))
  expect_true(qtestr(x, c(rules, "d"), depth = 1L))
  expect_false(qtestr(x, rules, depth = 2L))
  expect_false(qtestr(x, rules, depth = 3L))
})
