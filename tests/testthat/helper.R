# FIXME: Currently expected.label has to be passed, see
# https://github.com/hadley/testthat/issues/435

# FIXME: replace with expect_success (https://github.com/hadley/testthat/issues/436)
expect_expectation_successful = function(expr, info = NULL, label = NULL) {
  capture_expectation <- function(expr) tryCatch(expr, expectation = function(e) e)
  expect_is(capture_expectation(expr), "expectation_success", info = info, label = label)
}

# FIXME: replace with expect_success (https://github.com/hadley/testthat/issues/436)
expect_expectation_failed = function(expr, pattern = NULL, info = NULL, label = NULL) {
  capture_expectation <- function(expr) tryCatch(expr, expectation = function(e) e)
  expect_is(capture_expectation(expr), "expectation_failure", info = info, label = label)
}

expect_succ_all = function(part, x, ..., cc = as.character(substitute(part)), lc = convertCamelCase(cc)) {
  xn = deparse(substitute(x))

  s = paste0("check", cc)
  fun = match.fun(s)
  expect_true(fun(x, ...), label = s)

  if ("null.ok" %in% names(formals(fun))) {
    args = list(...)
    args["x"] = list(NULL)
    args$null.ok = TRUE
    expect_true(do.call(fun, args), info = s, label = xn)

    args$null.ok = FALSE
    expect_true(is.character(do.call(fun, args)), info = s, label = xn)
  }

  s = paste0("test", cc)
  fun = match.fun(s)
  expect_true(fun(x, ...), info = s, label = xn)

  s = paste0("test_", lc)
  fun = match.fun(s)
  expect_true(fun(x, ...), info = s, label = xn)

  s = paste0("assert", cc)
  fun = match.fun(s)
  expect_identical(fun(x, ...), x, info = s, label = xn, expected.label = xn)

  s = paste0("assert_", lc)
  fun = match.fun(s)
  expect_identical(fun(x, ...), x, info = s, label = xn, expected.label = xn)

  s = paste0("expect_", lc)
  fun = match.fun(s)
  expect_expectation_successful(fun(x, ...), info = s, label = xn)

  invisible(TRUE)
}

expect_fail_all = function(part, x, ..., cc = as.character(substitute(part)), lc = convertCamelCase(cc)) {
  xn = deparse(substitute(x))

  s = paste0("check", cc)
  fun = match.fun(s)
  res = fun(x, ...)
  expect_true(is.character(res) && nzchar(res), info = s, label = xn)

  if ("null.ok" %in% names(formals(fun))) {
    args = list(...)
    args["x"] = list(NULL)
    args$null.ok = TRUE
    expect_true(do.call(fun, args), info = s, label = xn)

    args$null.ok = FALSE
    expect_true(is.character(do.call(fun, args)), info = s, label = xn)
  }

  s = paste0("test", cc)
  fun = match.fun(s)
  expect_false(fun(x, ...), info = s, label = xn)

  s = paste0("test_", lc)
  fun = match.fun(s)
  expect_false(fun(x, ...), info = s, label = xn)

  s = paste0("assert", cc)
  fun = match.fun(s)
  expect_error(fun(x, ..., .var.name = xn), xn, info = s, label = xn)
  expect_error(fun(x, ...), "'x'", info = s, label = xn)

  s = paste0("assert_", lc)
  fun = match.fun(s)
  expect_error(fun(x, ..., .var.name = xn), xn, info = s, label = xn)
  expect_error(fun(x, ...), "'x'", info = s, label = xn)

  s = paste0("expect_", lc)
  fun = match.fun(s)
  expect_expectation_failed(fun(x, ...), pattern = "x", info = s, label = xn)
  expect_expectation_failed(fun(x, ..., label = xn), pattern = xn, info = s, label = xn)

  invisible(TRUE)
}
